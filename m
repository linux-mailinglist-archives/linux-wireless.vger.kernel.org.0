Return-Path: <linux-wireless+bounces-36265-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAYuJL83AmrmpAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36265-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 22:10:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 296CF5158B1
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 22:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5332F3041B88
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 20:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C2F37EFF4;
	Mon, 11 May 2026 20:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mokrynskyi.com header.i=@mokrynskyi.com header.b="c4iJ3gZL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.mokrynskyi.com (mail.mokrynskyi.com [65.109.39.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C799537F756
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 20:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.39.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530230; cv=none; b=mhyBKMtRfkdLcbSnBoDoWgNqAzPQU9w15aw6NiWd0uw/8MbOuJbBmIthn92wQSphWgCThzWMENcZo/0OTqs6ACmJ/YynYFYgTqWzUqNdSSERBplboS9FgWBBCeHFEFx9exNerU6yvV/tSiA7/JnA7oOK7f9778y7S6U1x/77DQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530230; c=relaxed/simple;
	bh=ztZdhbgWXhPzT0sfkkOZxRpF1XHqJWmOUFUhm+EdMvk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Gc8g+kxrkLIOrisJ73qubT6YF8XzU+YmW3h0q1H5FE6QX6ZpOFkGcEOAgjenWtF8tveZScmlXmsTFJMQe28VKkuEK4IcKwrjmZMjfPNSZ5eNBvBcs54niSv4RFyzqQidPu7VQU0F4J3RlCJiFbkz8GXguUCrlX/UP4B8UWndBlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mokrynskyi.com; spf=pass smtp.mailfrom=mokrynskyi.com; dkim=pass (2048-bit key) header.d=mokrynskyi.com header.i=@mokrynskyi.com header.b=c4iJ3gZL; arc=none smtp.client-ip=65.109.39.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mokrynskyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mokrynskyi.com
Message-ID: <07a1e340-cfdf-4027-861e-8f2a940bd21c@mokrynskyi.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mokrynskyi.com;
	s=dkim; t=1778530215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=giGsVPtUVT/cf4JDNMmZ8q221H1xhgSTW77E8jnggRk=;
	b=c4iJ3gZLyLub2VnuIdek26p/6ZfUDLXwzaKGw1N2qgoPHA6S5jOZVayFdX80HlM1J7JGf/
	qsGTEZrBz7P8Caas0G4NvmAzS4pfjeyTyyXNzApzg57ikTnFnHXFwW3KUHggQ+L5eKuZgt
	rgmVC57AAP/nLk4H+uPYMg0eXMmrjvhtnqQzz7lp8PmAdxJni9KNasiF/q9mIDjvY4ZmKt
	Dd06ocaDx4R7/3iKnADHPzRMhe+LtsWSDj+w448oeoy8/kYm/S2rbcWB0n2a98KkOhOsnu
	VNutY9RjS2cPtDTy0SIsr8u8Io2D8u+cq6wclH+gj4Pm4mzFD/gsHfPeKAQBIA==
Authentication-Results: mail.mokrynskyi.com;
	auth=pass smtp.mailfrom=nazar@mokrynskyi.com
Date: Mon, 11 May 2026 23:10:13 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nazar Mokrynskyi <nazar@mokrynskyi.com>
Subject: Re: [PATCH 2/2] wifi: ath12k: skip unknown direct buffer ring module
 IDs
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260505172415.566328-1-nazar@mokrynskyi.com>
 <20260505172415.566328-3-nazar@mokrynskyi.com>
 <89f30996-3210-403b-8c9a-52cf6d5fcb51@oss.qualcomm.com>
Content-Language: en-US, uk, uk-UA
In-Reply-To: <89f30996-3210-403b-8c9a-52cf6d5fcb51@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ---
X-Rspamd-Queue-Id: 296CF5158B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mokrynskyi.com,reject];
	R_DKIM_ALLOW(-0.20)[mokrynskyi.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[mokrynskyi.com:+];
	TAGGED_FROM(0.00)[bounces-36265-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nazar@mokrynskyi.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mokrynskyi.com:email,mokrynskyi.com:mid,mokrynskyi.com:dkim]
X-Rspamd-Action: no action


11.05.26 22:02, Jeff Johnson:
> On 5/5/2026 10:24 AM, Nazar Mokrynskyi wrote:
>> The firmware may advertise direct buffer ring capabilities for module
>> IDs beyond what the driver currently knows about (WMI_DIRECT_BUF_MAX).
>> This happens with newer firmware versions that support additional ring
>> types not yet implemented in the driver.
> What "newer firmware version" are you using that has this issue?
>
> Can you share the "Skipping unknown direct buf ring module id" logs from your
> modified driver?
ID is the same as in the original warning:

[   10.611560] ath12k_pci 0000:01:00.0: Invalid module id 2
[   10.616467] ath12k_pci 0000:01:00.0: failed to parse tlv -22

The firmware according to system logs (all this info is provided in [PATCH 0/2] email):

[    7.688137] ath12k_pci 0000:01:00.0: fw_version 0x160484db fw_build_timestamp 2025-12-09 20:09 fw_build_id QC_IMAGE_VERSION_STRING=WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1

This is running on OpenWRT 25.12, which uses 6.12.74 kernel with modules backported from 6.18.7 kernel:
[    0.000000] Linux version 6.12.74 (builder@buildhost) (x86_64-openwrt-linux-musl-gcc (OpenWrt GCC 14.3.0 r32802-f505120278) 14.3.0, GNU ld (GNU Binutils) 2.44) #0 SMP Wed Mar 25 20:09:53 2026
[    6.997293] Loading modules backported from Linux version v6.18.7-0-g5dfbc5357
[    6.999210] Backport generated by backports.git c8a37ce

>> The current code treats an unknown module_id as a fatal error, returning
>> -EINVAL and tearing down the entire driver initialization. This is
>> incorrect: the driver only needs to set up rings for types it uses
>> (SPECTRAL=0, CFR=1) and can safely ignore capability advertisements for
>> unknown types.
>>
>> Change the unknown module_id handling to skip the entry with a debug
>> message rather than failing, allowing initialization to proceed.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Nazar Mokrynskyi <nazar@mokrynskyi.com>
>> ---
>>  drivers/net/wireless/ath/ath12k/wmi.c | 12 ++++--------
>>  1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
>> index 484fdd3b1..0e776a8d8 100644
>> --- a/drivers/net/wireless/ath/ath12k/wmi.c
>> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
>> @@ -4814,10 +4814,10 @@ static int ath12k_wmi_dma_ring_caps(struct ath12k_base *ab,
>>  	dir_buff_caps = ab->db_caps;
>>  	for (i = 0; i < dma_caps_parse->n_dma_ring_caps; i++) {
>>  		if (le32_to_cpu(dma_caps[i].module_id) >= WMI_DIRECT_BUF_MAX) {
>> -			ath12k_warn(ab, "Invalid module id %d\n",
>> -				    le32_to_cpu(dma_caps[i].module_id));
>> -			ret = -EINVAL;
>> -			goto free_dir_buff;
>> +			ath12k_dbg(ab, ATH12K_DBG_WMI,
>> +				   "Skipping unknown direct buf ring module id %d\n",
>> +				   le32_to_cpu(dma_caps[i].module_id));
>> +			continue;
> by continuing you don't populate the dir_buff_caps[i] information below,
> leaving that record with zeroed data from the initial allocation. Does other
> code correctly handle that?
>
> would it be better to have a separate count of the number of dir_buff_caps
> records that are actually filled, and then update
> dma_caps_parse->n_dma_ring_caps to match once the parsing has completed?
I'm very far from kernel development, let alone ath12k driver specifically.
The patch is provided to better showcase the problems I had.
If there is a better way to address it, I'd really appreciate if someone more knowledgeable could take over, I just hope this is helpful.

With these changes QCN9274 runs an access point with over 3 weeks uptime as of right now.
That is not necessary the proof of anything, but it does seem to work in practice so far.
>>  		}
>>  
>>  		dir_buff_caps[i].id = le32_to_cpu(dma_caps[i].module_id);
>> @@ -4829,10 +4829,6 @@ static int ath12k_wmi_dma_ring_caps(struct ath12k_base *ab,
>>  	}
>>  
>>  	return 0;
>> -
>> -free_dir_buff:
>> -	ath12k_wmi_free_dbring_caps(ab);
>> -	return ret;
>>  }
>>  
>>  static void

