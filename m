Return-Path: <linux-wireless+bounces-124-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CB87FA958
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 19:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBC3E28164C
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 18:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA20364CD;
	Mon, 27 Nov 2023 18:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="tEUjaGnn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F182D59
	for <linux-wireless@vger.kernel.org>; Mon, 27 Nov 2023 10:57:29 -0800 (PST)
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
	by cmsmtp with ESMTPS
	id 7dtyrr0ojgpyE7gnQrGG2r; Mon, 27 Nov 2023 18:57:28 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 7gnPrpder97pz7gnPrRBda; Mon, 27 Nov 2023 18:57:27 +0000
X-Authority-Analysis: v=2.4 cv=ULDOoQTy c=1 sm=1 tr=0 ts=6564e697
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=HVNVOb/M/amC2CTWMSx8Ww==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10 a=vaJtXVxTAAAA:8
 a=3YZUj2ziSbBTNNMtSn8A:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=D+uEK9scvuvtsKJby+Bqflyj1NKw0ggctZxP2qGB2Pw=; b=tEUjaGnnYGgmncb4bamR1wOvDP
	GuMHeV0O8h+84PUk3esRi4cvKoXyBpazQmS2KX/EPM1NNTx067re/86E7MEKScKKlmgZZLb3GEXSx
	tKT7bxjxW2R/Zj5dxyHJHrBYsKf9rkMiqPXP1qlEw5+lZSfYP31RjXjVg2Kx8Nh+ujaX9j/eP5qla
	/CqmR8eQb2iIlcfYhXXs8ZCUe0h/g3cleIkMYI3Ahg2fWrn3HMarX+xcM81wDgIBKUj+CS9+P92EW
	n5ta4MP2J2+6wj4uN/bvTj1mok5FAJy6CQmiZDHw08SoK/ySRNXfevFQy3VqPmIzmcr/AuLB/c5yA
	hUCSuckg==;
Received: from 189.215.210.122.cable.dyn.cableonline.com.mx ([189.215.210.122]:11511 helo=[192.168.0.9])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1r7gnO-001W9i-2P;
	Mon, 27 Nov 2023 12:57:26 -0600
Message-ID: <d556055f-64f0-4f98-9d1a-6ea1f74f8461@embeddedor.com>
Date: Mon, 27 Nov 2023 12:57:25 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: use __counted_by for the rest of flexible
 array members
Content-Language: en-US
To: Dmitry Antipov <dmantipov@yandex.ru>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 linux-wireless@vger.kernel.org
References: <20231127112601.42636-1-dmantipov@yandex.ru>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231127112601.42636-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.215.210.122
X-Source-L: No
X-Exim-ID: 1r7gnO-001W9i-2P
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 189.215.210.122.cable.dyn.cableonline.com.mx ([192.168.0.9]) [189.215.210.122]:11511
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGhdYEmjbB1hpWssPO8aOB0EH7CgbPPuOGjRdxGrGc9vUX44b6tLMkMCBNKgMUv1k86tp4IJesPy3npkzr30fkwd4sjoE0NVQuNK3h3tKdciWizSU9PO
 K0+hWXhSy8bDzKtJjjSuZux+gZMXmO1BpOomAiHkbry+o7PSos8Ul3b2T2nHm0xQoj/eB2314pTZfI7domnwSW/3XDfGIhXg16oEbu3w2gc+8b9Jg2gDRyPt



On 11/27/23 05:25, Dmitry Antipov wrote:
> Following commit 9118796dfa67 ("wifi: mac80211: Add __counted_by for struct
> ieee802_11_elems and use struct_size()"), use an incoming '__counted_by()'
> attribute for the flexible array members of 'struct probe_resp', 'struct
> fils_discovery_data', 'struct unsol_bcast_probe_resp_data', 'struct
> ieee80211_mgd_auth_data' and 'struct ieee80211_mgd_assoc_data', as well as
> 'struct_size()' helper to allocate an instances of them where appropriate.
> This also introduces reordering of statements in 'ieee80211_mgd_auth()'
> and 'ieee80211_mgd_assoc()' because the counter field should (is better
> to?) be adjusted before touching the corresponding '__counted_by()' area.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>   net/mac80211/cfg.c         |  7 ++++---
>   net/mac80211/ieee80211_i.h | 10 +++++-----
>   net/mac80211/mlme.c        | 17 +++++++++--------
>   3 files changed, 18 insertions(+), 16 deletions(-)

[..]

>   struct ieee80211_sta_tx_tspec {
> diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
> index 887b496f2b81..41a4719fb413 100644
> --- a/net/mac80211/mlme.c
> +++ b/net/mac80211/mlme.c
> @@ -7322,8 +7322,9 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
>   	}
>   	rcu_read_unlock();
>   
> -	auth_data = kzalloc(sizeof(*auth_data) + req->auth_data_len +
> -			    req->ie_len, GFP_KERNEL);
> +	auth_data = kzalloc(struct_size(auth_data, data,
> +					req->auth_data_len +
> +					req->ie_len), GFP_KERNEL);

I think we can use size_add() here.

>   	if (!auth_data)
>   		return -ENOMEM;
>   
> @@ -7340,9 +7341,9 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
>   			auth_data->sae_trans = le16_to_cpu(pos[0]);
>   			auth_data->sae_status = le16_to_cpu(pos[1]);
>   		}
> +		auth_data->data_len += req->auth_data_len - 4;
>   		memcpy(auth_data->data, req->auth_data + 4,
>   		       req->auth_data_len - 4);
> -		auth_data->data_len += req->auth_data_len - 4;
>   	}
>   
>   	/* Check if continuing authentication or trying to authenticate with the
> @@ -7354,9 +7355,9 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
>   		    ifmgd->auth_data->link_id == req->link_id;
>   
>   	if (req->ie && req->ie_len) {
> +		auth_data->data_len += req->ie_len;
>   		memcpy(&auth_data->data[auth_data->data_len],

This introduces a bug. Now, memcpy() will copy data into `data[]` after the
offset is updated, which will cause an overwrite bug.

 From a piece of code above it seems that

if (req->auth_data_len >= 4)
	memcpy(&auth_data->data[req->auth_data_len - 4], ..);
else
	memcpy(&auth_data->data[0], ..);

So, we should probably use an auxiliary variable like this

+               auth_data->data_len += req->auth_data_len - 4;
                 memcpy(auth_data->data, req->auth_data + 4,
                        req->auth_data_len - 4);
-               auth_data->data_len += req->auth_data_len - 4;
         }
+       aux_len = auth_data->data_len;

and then

         if (req->ie && req->ie_len) {
-               memcpy(&auth_data->data[auth_data->data_len],
-                      req->ie, req->ie_len);
                 auth_data->data_len += req->ie_len;
+               memcpy(&auth_data->data[aux_len], req->ie, req->ie_len);
         }


--
Gustavo

>   		       req->ie, req->ie_len);
> -		auth_data->data_len += req->ie_len;
>   	}
>   
>   	if (req->key && req->key_len) {
> @@ -7637,16 +7638,16 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
>   	struct ieee80211_bss *bss;
>   	bool override;
>   	int i, err;
> -	size_t size = sizeof(*assoc_data) + req->ie_len;
> +	size_t extra = req->ie_len;
>   
>   	for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++)
> -		size += req->links[i].elems_len;
> +		extra += req->links[i].elems_len;
>   
>   	/* FIXME: no support for 4-addr MLO yet */
>   	if (sdata->u.mgd.use_4addr && req->link_id >= 0)
>   		return -EOPNOTSUPP;
>   
> -	assoc_data = kzalloc(size, GFP_KERNEL);
> +	assoc_data = kzalloc(struct_size(assoc_data, ie, extra), GFP_KERNEL);
>   	if (!assoc_data)
>   		return -ENOMEM;
>   
> @@ -7811,8 +7812,8 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
>   	       sizeof(ifmgd->s1g_capa_mask));
>   
>   	if (req->ie && req->ie_len) {
> -		memcpy(assoc_data->ie, req->ie, req->ie_len);
>   		assoc_data->ie_len = req->ie_len;
> +		memcpy(assoc_data->ie, req->ie, req->ie_len);
>   		assoc_data->ie_pos = assoc_data->ie + assoc_data->ie_len;
>   	} else {
>   		assoc_data->ie_pos = assoc_data->ie;

