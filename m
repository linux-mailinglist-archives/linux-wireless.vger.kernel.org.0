Return-Path: <linux-wireless+bounces-19884-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0637A54836
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F1427A55EB
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD32020A5D1;
	Thu,  6 Mar 2025 10:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="TsS6odNZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C55A2080FB;
	Thu,  6 Mar 2025 10:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257832; cv=none; b=UBBOJDjpWRbs7zXr/pr2L8/ydpL2N9xnVt6HsDyfTJjjz3RQqZUfH0232F2P4nsojBS/cs/avr5yeOonUp4Gp58wslzyY1kOznM6ENmEdNeHTsaVbc0zwAe1hM7gCSyRA1OVJ89cy7sajO+YqCl8txYK2rUvEj+gzSB9HYUmh6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257832; c=relaxed/simple;
	bh=61sTIcpxdnrd5cAzz31qmm4JpGHVL+BQuYWc+ewBL0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faBr7sQZbGntqTRoYuG+UDoZHPh62EV3OI/QJ7Kjjm4KsJA2+0ViZK4N/KlaSoYqsmv2CVbTf6y4C9La9q1jqxOavqx1WPi1LqorY+/l9vivLH53RuzYHs7MJ3rnfgHLd+et8R+gzKYszaOAhwT/5fUiqk0gV8ZSVf5urZMsSHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=TsS6odNZ; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 1B57B1F96B;
	Thu,  6 Mar 2025 11:43:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1741257828;
	bh=nskpp7xo6FpLd4tlbD/YpaMXfWmCB453KZHTU3uQAM0=; h=From:To:Subject;
	b=TsS6odNZBTXg+Cr73aZnO1/h+0iST9hQ0jgjlq0VHydLXfbuV82vxG7BTe6N9cDDm
	 8Hwmh0zmDW8oc6LXsea7GipXU692PHnfNy3uquP4rb0HSuznK9ZSmQP5WHbkr5PEYh
	 T3TABKJJUBa/IGDpyKyjqGyKaD3Ghsq2GP/Hvxb/IcgH/HtYwuyxpQY6znZw0z3H0i
	 +g5DCt+IJTTcVhDgvfAjEGseMjavNgtQnsiNp0A49pbfNPDXY7I7f4nXE042Sn0ejN
	 aAhvHbupOS1tQ3F+8wlXIi7Ji3mxZ3tZXQnVmb/0r1a30hwnyGcM60E2Sxvk+pSX8D
	 l1eZci3LH9ohQ==
Date: Thu, 6 Mar 2025 11:43:46 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Jeff Chen <jeff.chen_1@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, johannes@sipsolutions.net,
	francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de
Subject: Re: [PATCH v3 1/2] wifi: mwifiex: Part A of resolving the failure in
 downloading calibration data.
Message-ID: <20250306104346.GC19853@francesco-nb>
References: <20250205012843.758714-1-jeff.chen_1@nxp.com>
 <20250220061143.1417420-1-jeff.chen_1@nxp.com>
 <20250220061143.1417420-2-jeff.chen_1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220061143.1417420-2-jeff.chen_1@nxp.com>

Hello Jeff,

On Thu, Feb 20, 2025 at 02:11:42PM +0800, Jeff Chen wrote:
> This patch corrects the command format used for downloading RF
> calibration data to the firmware.

Do we need any fixes tag? is this supposed to be backported to stable?

Was the command format always broken? Do this format depends on the
firmware version? We would need to explain why changing the format of
this command here is safe.

> 
> This patch is a split from the previous submission.
> 
> Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
> ---
>  drivers/net/wireless/marvell/mwifiex/fw.h      |  7 +++++++
>  drivers/net/wireless/marvell/mwifiex/sta_cmd.c | 14 +++++++++-----
>  2 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
> index 4a96281792cc..0c75a574a7ee 100644
> --- a/drivers/net/wireless/marvell/mwifiex/fw.h
> +++ b/drivers/net/wireless/marvell/mwifiex/fw.h
> @@ -2352,6 +2352,12 @@ struct host_cmd_ds_add_station {
>  	u8 tlv[];
>  } __packed;
>  
> +struct host_cmd_ds_802_11_cfg_data {
> +	__le16 action;
> +	__le16 type;
> +	__le16 data_len;
> +} __packed;
> +
>  struct host_cmd_ds_command {
>  	__le16 command;
>  	__le16 size;
> @@ -2431,6 +2437,7 @@ struct host_cmd_ds_command {
>  		struct host_cmd_ds_pkt_aggr_ctrl pkt_aggr_ctrl;
>  		struct host_cmd_ds_sta_configure sta_cfg;
>  		struct host_cmd_ds_add_station sta_info;
> +		struct host_cmd_ds_802_11_cfg_data cfg_data;
>  	} params;
>  } __packed;
>  
> diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
> index e2800a831c8e..6e7b2b5c7dc5 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
> +++ b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
> @@ -1500,18 +1500,19 @@ int mwifiex_dnld_dt_cfgdata(struct mwifiex_private *priv,
>  
>  /* This function prepares command of set_cfg_data. */
>  static int mwifiex_cmd_cfg_data(struct mwifiex_private *priv,
> -				struct host_cmd_ds_command *cmd, void *data_buf)
> +				struct host_cmd_ds_command *cmd, void *data_buf, u16 cmd_action)
>  {
>  	struct mwifiex_adapter *adapter = priv->adapter;
>  	struct property *prop = data_buf;
>  	u32 len;
>  	u8 *data = (u8 *)cmd + S_DS_GEN;
>  	int ret;
> +	struct host_cmd_ds_802_11_cfg_data *pcfg_data = &cmd->params.cfg_data;
>  
>  	if (prop) {
>  		len = prop->length;
>  		ret = of_property_read_u8_array(adapter->dt_node, prop->name,
> -						data, len);
> +						data + sizeof(*pcfg_data), len);
>  		if (ret)
>  			return ret;
>  		mwifiex_dbg(adapter, INFO,
> @@ -1519,15 +1520,18 @@ static int mwifiex_cmd_cfg_data(struct mwifiex_private *priv,
>  			    prop->name);
>  	} else if (adapter->cal_data->data && adapter->cal_data->size > 0) {
>  		len = mwifiex_parse_cal_cfg((u8 *)adapter->cal_data->data,
> -					    adapter->cal_data->size, data);
> +					    adapter->cal_data->size, data + sizeof(*pcfg_data));
>  		mwifiex_dbg(adapter, INFO,
>  			    "download cfg_data from config file\n");
>  	} else {
>  		return -1;
>  	}
>  
> +	pcfg_data->action = cpu_to_le16(cmd_action);
> +	pcfg_data->type = cpu_to_le16(2);
> +	pcfg_data->data_len = cpu_to_le16(len);
>  	cmd->command = cpu_to_le16(HostCmd_CMD_CFG_DATA);
> -	cmd->size = cpu_to_le16(S_DS_GEN + len);
> +	cmd->size = cpu_to_le16(S_DS_GEN + sizeof(*pcfg_data) + len);
>  
>  	return 0;
>  }
> @@ -1949,7 +1953,7 @@ int mwifiex_sta_prepare_cmd(struct mwifiex_private *priv, uint16_t cmd_no,
>  		ret = mwifiex_cmd_get_hw_spec(priv, cmd_ptr);
>  		break;
>  	case HostCmd_CMD_CFG_DATA:
> -		ret = mwifiex_cmd_cfg_data(priv, cmd_ptr, data_buf);
> +		ret = mwifiex_cmd_cfg_data(priv, cmd_ptr, data_buf, cmd_action);
>  		break;
>  	case HostCmd_CMD_MAC_CONTROL:
>  		ret = mwifiex_cmd_mac_control(priv, cmd_ptr, cmd_action,
> -- 
> 2.34.1
> 

