Return-Path: <linux-wireless+bounces-35986-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oP0MKPvd+mmGTgMAu9opvQ
	(envelope-from <linux-wireless+bounces-35986-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 08:21:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 412044D68AB
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 08:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C0207301F3D5
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 06:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A06B2556E;
	Wed,  6 May 2026 06:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRFuCnBv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1C53016E0
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 06:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778048502; cv=none; b=titdGBZqLKzIDCk4d2UCJErcZO55zmwtUmER2j5EPK7MS1LU0VrCzhLuIJqepJEhd0NvGQjBlEhkM3HDgItEqgFUimgBXnxoY+U8JSK7D5Q4rzEGVGDQLiobUHpD6VQsVJnsemVFVN1ErrIoiXwar7evTGbdINx1uTWkc5SF9QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778048502; c=relaxed/simple;
	bh=G/iAflbvT5WW4nJ/TROYpVvE8ja8RD3uDGolmd2Woic=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=VkBpsbTiGUH9c0DtTapLRIF8noSNhls7hwKmgUY71D1BwfSlIOcSWtDMudwOxtbpeLxmw8OrmAB7R7QtFjMTRGXxf6h0sAQxEuXMPEe/oxcBMdshV+tO2RoXUZCVhVdHY0ziAGDzRs0SxwXj/V9MIxPDxao7IKXsx4hHo5Cix40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRFuCnBv; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488d2079582so62325245e9.2
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 23:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778048499; x=1778653299; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeddDN/7F4d5Y5O9u+ksHzBhx/JshclNIDmnp14S2mc=;
        b=iRFuCnBvuRn21roTd47jmTOHoS5fbyNy5SNJj2c2kQsd7HvF9j47pRIBFUiogloV0Q
         I+ZqfxxUQvMxt6UR+iBVsEAOxjnhgGV0NHSJiSsPZ44HkRSiI7bq6J103tooWnbGCNoa
         J9nhAntWpb6+y7hqBTxebIBZMVJZcfm0z/yNn5Noay5S5i/hOa5Ovy3NqATqQXgl7Sc/
         Ozx2rf7PrhWKOE7RTz/xqn59Pu5zydLC7JEmCauO8Zj3Ck/TDZ3od6xNk1h7A1mlrtxP
         x7GapnWMYSLKabulH6QVnNnyIHvJIjQgyo8mmh2Wp9TWgOR8f5MwIFmlMMyILEvX/qYW
         obCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778048499; x=1778653299;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YeddDN/7F4d5Y5O9u+ksHzBhx/JshclNIDmnp14S2mc=;
        b=h9BTlHRwtHTjoNoMf0euJaZ+e92aCkyOlXszdSYdgKrBLQCxgWRVHmN+LF4lYdZH4X
         c7pY9sW3lQv0RrlgXL8Udjiw+eUSAwJoBOsjQlEYzt8GoLH2ZFCF90JnjGPcSll5eJsK
         VgF3HZT494a4r9BxdFv+U/DoN0ON1TTpvyTY2z6bUcuAIgg0YETdhaQpWG0UXQdlTfWf
         FYgQMrt+4fHXi0mI6gobrw0CQnebjDCLNVrcYrzkzy8TtGBWug9w7QZ9X3yuQIL3CP9z
         Ha5MJDPlssDFXz3OMNNfy3dxMsotdGq7G7jukGvKdvM1zTiHgTbnaZn1RL7zsYDW0ERb
         au8w==
X-Gm-Message-State: AOJu0YxRWWHQ3bgwBQwj8R+gEwvfe1zGDFsptl6Y1XfeVeZJFufonIzB
	pWZkRiwjG16Tl5hB+Npx3q+RPdWhqPYgwC1/ZykM/R4UwfIjcUoST39QrDlkTA==
X-Gm-Gg: AeBDievxvviYzwYRqD4ioKQbt6FOjA8K20XPDPMkj3xUYImxvtc3NBp7T+/gRjmYDr+
	l9hNjWANDBElwmoHQY0tZvhcFXZ/py901YmTPWQ8aGfBYVMxzeQLgAUv/jLQ2h6VUxNzhYRk4Qy
	wQumwypcacrOb/hRS4aQznfZaIQOjOesy1r10VfxvGIMnlWtpMny2mA1kFyoAIyjfmB65MHrU86
	aYcpotVyrhPpX0jG4fLRbOV9AUNgbY95ixU+GyAESADUhNJK0B3YU+G9Y/B/2ygn8i3QhsEYTPz
	2dbQIW6CxRZBXkS4nhubOmGD7gqWbKIQsJeHpz6u9P/aKUia8kVH7G/Omhc77Ka7NUdygXtWynB
	D+J5DKSsw1rUJoqXRbKKLZ4SeVGxXz94Fe28RSJB5AVhVbq48Llm3PRjoHqIrW7SiKgrM4v36E1
	8MUVCVwah3ZRbBunULYXrJ14F/YoHNcFrZHb8UdOh5bAzQ3sI+2cU5
X-Received: by 2002:a05:600c:2d16:b0:48a:72ab:f88c with SMTP id 5b1f17b1804b1-48e52be1069mr12666785e9.17.1778048498987;
        Tue, 05 May 2026 23:21:38 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e530b2947sm9010655e9.4.2026.05.05.23.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 23:21:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 May 2026 08:21:38 +0200
Message-Id: <DIBDL7QAG5YF.3JNT6EYASRT7W@gmail.com>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 2/2] wifi: ath11k: fix error path leaks in some WMI
 calls
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Rameshkumar Sundaram" <rameshkumar.sundaram@oss.qualcomm.com>, "Nicolas
 Escande" <nico.escande@gmail.com>, <ath11k@lists.infradead.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260502071453.2379188-1-nico.escande@gmail.com>
 <20260502071453.2379188-3-nico.escande@gmail.com>
 <151425e9-564d-4d61-b37d-3eef9bc54b6f@oss.qualcomm.com>
In-Reply-To: <151425e9-564d-4d61-b37d-3eef9bc54b6f@oss.qualcomm.com>
X-Rspamd-Queue-Id: 412044D68AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35986-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicoescande@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Tue May 5, 2026 at 7:23 PM CEST, Rameshkumar Sundaram wrote:
> On 5/2/2026 12:44 PM, Nicolas Escande wrote:
>> This is the same pattern that was previously identified as problematic:
>> direct 'return ath11k_wmi_cmd_send(...)' will leak the skb in the error
>> path if it is not explicitly handled.
>>=20
>> Fixes: c417b247ba04 ("ath11k: implement hardware data filter")
>> Fixes: 9cbd7fc9be82 ("ath11k: support MAC address randomization in scan"=
)
>> Fixes: ba9177fcef21 ("ath11k: Add basic WoW functionalities")
>> Fixes: fec4b898f369 ("ath11k: Add WoW net-detect functionality")
>> Fixes: c3c36bfe998b ("ath11k: support ARP and NS offload")
>> Fixes: a16d9b50cfba ("ath11k: support GTK rekey offload")
>> Fixes: 652f69ed9c1b ("ath11k: Add support for SAR")
>> Fixes: 0f84a156aa3b ("ath11k: Handle keepalive during WoWLAN suspend and=
 resume")
>> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
>> ---
>>   drivers/net/wireless/ath/ath11k/wmi.c | 112 ++++++++++++++++++++++----
>>   1 file changed, 96 insertions(+), 16 deletions(-)
>>=20
>> diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireles=
s/ath/ath11k/wmi.c
>> index 024c2aad9fb4..dca6e011cc40 100644
>> --- a/drivers/net/wireless/ath/ath11k/wmi.c
>> +++ b/drivers/net/wireless/ath/ath11k/wmi.c
>> @@ -9299,7 +9299,7 @@ int ath11k_wmi_hw_data_filter_cmd(struct ath11k *a=
r, u32 vdev_id,
>>   {
>>   	struct wmi_hw_data_filter_cmd *cmd;
>>   	struct sk_buff *skb;
>> -	int len;
>> +	int ret, len;
>>  =20
>>   	len =3D sizeof(*cmd);
>>   	skb =3D ath11k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
>> @@ -9324,7 +9324,13 @@ int ath11k_wmi_hw_data_filter_cmd(struct ath11k *=
ar, u32 vdev_id,
>>   		   "hw data filter enable %d filter_bitmap 0x%x\n",
>>   		   enable, filter_bitmap);
>>  =20
>> -	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_HW_DATA_FILTER_CMDID);
>> +	ret =3D ath11k_wmi_cmd_send(ar->wmi, skb, WMI_HW_DATA_FILTER_CMDID);
>> +	if (ret) {
>> +		ath11k_warn(ar->ab, "failed to send WMI_HW_DATA_FILTER_CMDID\n");
>> +		dev_kfree_skb(skb);
>> +	}
>> +
>> +	return ret;
>>   }
>>
>
> { .. }
>
>
>> @@ -10053,7 +10127,13 @@ int ath11k_wmi_sta_keepalive(struct ath11k *ar,
>>   		   "sta keepalive vdev %d enabled %d method %d interval %d\n",
>>   		   arg->vdev_id, arg->enabled, arg->method, arg->interval);
>>  =20
>> -	return ath11k_wmi_cmd_send(wmi, skb, WMI_STA_KEEPALIVE_CMDID);
>> +	ret =3D ath11k_wmi_cmd_send(wmi, skb, WMI_STA_KEEPALIVE_CMDID);
>> +	if (ret) {
>> +		ath11k_warn(ar->ab, "failed to send WMI_STA_KEEPALIVE_CMDID\n");
>> +		dev_kfree_skb(skb);
>> +	}
>> +
>> +	return ret;
>>   }
>>  =20
>>   bool ath11k_wmi_supports_6ghz_cc_ext(struct ath11k *ar)
>
>
> Thanks for fixing these. One more instance of the same pattern remains=20
> in ath11k_tm_cmd_wmi_ftm().
>
Ha nice catch, I originally skipped it because I saw there was a 'if (ret)'=
 and
assumed it had the proper error handling.

> Please add dev_kfree_skb(skb) before goto out, matching=20
> ath11k_tm_cmd_wmi() above.
Yes seems it needs it's own patch and fixes tag. I'll respin the series the=
n.

Thanks

