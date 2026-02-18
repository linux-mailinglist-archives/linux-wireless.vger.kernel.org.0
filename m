Return-Path: <linux-wireless+bounces-31993-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBy1MuZblmkdeQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31993-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 01:40:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D0415B315
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 01:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CBCF304CCE5
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 00:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E343E1FCFFC;
	Thu, 19 Feb 2026 00:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="TFvzcemT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2DC1F419A
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 00:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771461579; cv=none; b=glP9KDChQcIWiYu/yRl+Zjcmxy5MMYFc8TpWPRASDq0CYKaxzz+HWbxCqePi1+fLY5TIL4czPp+uustFY9DoYRgxxTTKS085ZDv85nf+9405AbHYyecZZu+Dg367XLyO0N2Bdy6sG7OWzRBFn4ht4EBOZnmlVYdHy0JHhRSTZVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771461579; c=relaxed/simple;
	bh=z6syF4LidYTHWoLqxLqQLWmNiefVyfFzZH9TK+S8Qhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ob0kwwfgLYkmZ9Jv1s7M4X5OqJVjG/PZisEiQSvE5FBdJRVy4ULMRgffY8ElJtA5qfeofFVwRbMsWn+wvg49qEmewoDHcpz77QswKOxmzTVQDIJ6KDiWAKcrp+NCa63xZTPyrozpWFnLyShZ+p8tJjw1xPbshJ2WDAj4dwnzGec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=TFvzcemT; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id soudv8Y87Skcfss4qvHxs6; Thu, 19 Feb 2026 00:39:32 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id ss4pvFpadqfpWss4pvhlH7; Thu, 19 Feb 2026 00:39:31 +0000
X-Authority-Analysis: v=2.4 cv=A55sP7WG c=1 sm=1 tr=0 ts=69965bc4
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=k5Y5iPg+dmTXVWgYE/XtfQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=9YR8UghG2Mux9z_Xfx4A:9 a=QEXdDO2ut3YA:10 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+/cI9yYaTzTcqdQ58iWogswfNeVO0Pn3cSXKnRlVUwg=; b=TFvzcemTtvfbWw5mv7eH4IFz4W
	/gVUCTw9e07wPvK/Q+SoU5UMs0ZlpWO/rCEEPaXcbjBiNViNdd6S0/SAOQMNPfq3iqC7tUQC07wW0
	Zf1HERNpDc4C9NyNtbpUFxkU9bypsTUphtjFlhTIAkLYjOSi8RnzDO48DiTZmfNDVYBtvDETrz+JM
	g1qb3NVVpMgApSCaaJI8KnkCLWvWI22RgecPTwSnuOqtwO5clQt/Zhhygyd3JTwRl6Gm7liyqA5J/
	Ae6H17Vj4Fc8HgUoh934JB6KT0K//0LOZWXjUPNa7m+soVVf66Ki5p2w5TJS98DcB7pkcKajE/jRt
	ueo11Deg==;
Received: from [177.238.16.13] (port=37088 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vss4o-00000003gCK-41Zb;
	Wed, 18 Feb 2026 18:39:31 -0600
Message-ID: <6305fbc7-8210-4f4d-b719-30ba038611af@embeddedor.com>
Date: Wed, 18 Feb 2026 18:38:41 +0900
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] wifi: ath6kl: wmi: Avoid
 -Wflex-array-member-not-at-end warning
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Kalle Valo <quic_kvalo@quicinc.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <aZP4RI-uN2001cBh@kspp>
 <d2a02b4c-5f69-4f5e-bc0e-428b64e99d36@oss.qualcomm.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <d2a02b4c-5f69-4f5e-bc0e-428b64e99d36@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.16.13
X-Source-L: No
X-Exim-ID: 1vss4o-00000003gCK-41Zb
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.16.13]:37088
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFyGbEr6S8eeDlMVCMumI1KTmm8S+8gMC2dK2Z9li+lomd9XWHgqenvINFn10BUee1eUaNvM24jOXQ6i1moPWaAcQfLb0T2LPXAVnS1MMJCjwd69xVd+
 03drLjjeL3LAXu93YNoxCyXZ4250uBBWmdBnzTvSrwAiL9USAt3EmMfwPlziZqeaPtG+vWxSElhwcjJoPZ+O4q3J59fvO0Bpjvp5MAAM2L7a5XinM5tFdFdD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[embeddedor.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31993-lists,linux-wireless=lfdr.de];
	DMARC_NA(0.00)[embeddedor.com];
	HAS_X_SOURCE(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[embeddedor.com:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gustavo@embeddedor.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	HAS_X_ANTIABUSE(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,embeddedor.com:mid]
X-Rspamd-Queue-Id: 33D0415B315
X-Rspamd-Action: no action


>> @@ -1652,7 +1656,7 @@ struct roam_ctrl_cmd {
>>   	union {
>>   		u8 bssid[ETH_ALEN]; /* WMI_FORCE_ROAM */
>>   		u8 roam_mode; /* WMI_SET_ROAM_MODE */
>> -		struct bss_bias_info bss; /* WMI_SET_HOST_BIAS */
>> +		struct bss_bias_info_hdr bss; /* WMI_SET_HOST_BIAS */
>>   		struct low_rssi_scan_params params; /* WMI_SET_LRSSI_SCAN_PARAMS
>>   						     */
>>   	} __packed info;
> 
> That bss member appears to be completely unused
> (bssid, roam_mode, and params are used)
> 
> So IMO the better solution is to remove bss from the union.
> And I think struct bss_bias and struct bss_bias_info can also be removed.

Even if they're not used, are you sure they aren't there simply	
to define the memory layout of struct roam_ctrl_cmd?

As Kees commented[1], struct roam_ctrl_cmd appears to be a
hardware interface... See below:

drivers/net/wireless/ath/ath6kl/wmi.c:
  755 /*
  756  * Mechanism to modify the roaming behavior in the firmware. The lower rssi
  757  * at which the station has to roam can be passed with
  758  * WMI_SET_LRSSI_SCAN_PARAMS. Subtract 96 from RSSI to get the signal level
  759  * in dBm.
  760  */
  761 int ath6kl_wmi_set_roam_lrssi_cmd(struct wmi *wmi, u8 lrssi)
  762 {
  763         struct sk_buff *skb;
  764         struct roam_ctrl_cmd *cmd;
  765
  766         skb = ath6kl_wmi_get_new_buf(sizeof(*cmd));
  767         if (!skb)
  768                 return -ENOMEM;
  769
  770         cmd = (struct roam_ctrl_cmd *) skb->data;
...
}

Thanks
-Gustavo

[1] https://lore.kernel.org/linux-hardening/202601151627.99DFE54@keescook/


