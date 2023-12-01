Return-Path: <linux-wireless+bounces-272-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE54980080B
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 11:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7F1282765
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 10:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D78208C3;
	Fri,  1 Dec 2023 10:15:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE64884;
	Fri,  1 Dec 2023 02:15:35 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 732F220645;
	Fri,  1 Dec 2023 11:15:33 +0100 (CET)
Date: Fri, 1 Dec 2023 11:15:31 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, kvalo@kernel.org, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com
Subject: Re: [PATCH v7 02/12] wifi: mwifiex: fixed group rekey issue for WPA3.
Message-ID: <ZWmyQ9ilyAPGJmft@francesco-nb.int.toradex.com>
References: <20231128083115.613235-1-yu-hao.lin@nxp.com>
 <20231128083115.613235-3-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128083115.613235-3-yu-hao.lin@nxp.com>

On Tue, Nov 28, 2023 at 04:31:05PM +0800, David Lin wrote:
> If host mlme is enabled, gropu rekey offload should be disabled.
> 
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> ---
>  drivers/net/wireless/marvell/mwifiex/cfg80211.c | 3 +++
>  drivers/net/wireless/marvell/mwifiex/main.c     | 4 ++++
>  drivers/net/wireless/marvell/mwifiex/util.c     | 7 +++++++
>  3 files changed, 14 insertions(+)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> index 40c39e4765f7..3d59e6a441b9 100644
> --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> @@ -3657,6 +3657,9 @@ static int mwifiex_set_rekey_data(struct wiphy *wiphy, struct net_device *dev,
>  	if (!ISSUPP_FIRMWARE_SUPPLICANT(priv->adapter->fw_cap_info))
>  		return -EOPNOTSUPP;
>  
> +	if (priv->adapter->host_mlme)
> +		return 0;

this is a fixup of the previous patch, you should not introduce an issue
and fix it in the following patch. Please make it correct in the first
place fixing up that patch.


> +
>  	return mwifiex_send_cmd(priv, HostCmd_CMD_GTK_REKEY_OFFLOAD_CFG,
>  				HostCmd_ACT_GEN_SET, 0, data, true);
>  }
> diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
> index d99127dc466e..3bebb6c37604 100644
> --- a/drivers/net/wireless/marvell/mwifiex/main.c
> +++ b/drivers/net/wireless/marvell/mwifiex/main.c
> @@ -802,6 +802,10 @@ mwifiex_bypass_tx_queue(struct mwifiex_private *priv,
>  			    "bypass txqueue; eth type %#x, mgmt %d\n",
>  			     ntohs(eth_hdr->h_proto),
>  			     mwifiex_is_skb_mgmt_frame(skb));
> +		if (ntohs(eth_hdr->h_proto) == ETH_P_PAE)
> +			mwifiex_dbg(priv->adapter, MSG,
> +				    "key: send EAPOL to %pM\n",
> +				    eth_hdr->h_dest);

this is just debug code, at a first glance not sure i
> diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
> index 23675c1cecae..ff1b2f162c30 100644
> --- a/drivers/net/wireless/marvell/mwifiex/util.c
> +++ b/drivers/net/wireless/marvell/mwifiex/util.c
> @@ -482,8 +482,15 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *priv,
>  				return 0;
>  
>  			if (ieee80211_is_deauth(ieee_hdr->frame_control)) {
> +				mwifiex_dbg(priv->adapter, MSG,
> +					    "auth: receive deauth from %pM\n",
> +					    ieee_hdr->addr3);
ditto

>  				priv->auth_flag = 0;
>  				priv->auth_alg = 0xFFFF;
> +			} else {
> +				mwifiex_dbg(priv->adapter, MSG,
> +					    "assoc: receive disasso from %pM\n",
> +					    ieee_hdr->addr3);
ditto


