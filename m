Return-Path: <linux-wireless+bounces-33290-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHIiMQXPt2mDVgEAu9opvQ
	(envelope-from <linux-wireless+bounces-33290-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 10:36:05 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD13B29718A
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 10:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07B523004D3B
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 09:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A2D21D3E2;
	Mon, 16 Mar 2026 09:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dijyEkQ8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E5216A395
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 09:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773653760; cv=none; b=AlxvRaev8vybvIr07amecSe3I8D1RSbAV21twcZKZqJaLXKsGV2Ezh5dgTO3JqEFWdmCT8xBODyp2AevtidBk3+crMJ2abz3e+J2DTSNDVg1JkZnap6QXvIVo1XnucOpk1CmJmZKpzvQqtz/mCHC7gz5854v7fSh2+wNKqdOywQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773653760; c=relaxed/simple;
	bh=U4mFZ8uHd5mcaf3kLs7A9U9MTtjM2OWz4W1vp8Bu96E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=El5Em5mdEbHoLF2JBsCxPJbrBF5ihfQl8XxdHfA8Sbr08YxdQTbkOQrwm0c6UeOqa7StGm0s2XH/QL88/HAjU31umoUxiJoN0WGRbffu/btzoKUDS1hkiCgvGP+7sZvBs+x56n4XAH/8/ZYKpqQuzOTduCWDuHJ889QwKXd5ShM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dijyEkQ8; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439b8a3f2bcso3065421f8f.3
        for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 02:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773653757; x=1774258557; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gseK4icojgYbBuoL5AHgGpLJevZBa1SV0g5b00g6iUM=;
        b=dijyEkQ8QG1Tk0pjY8q6VQLoWl4bSkFyhO4gxWZNcF5Jq0mik9lcwL4V7pEu2i9gWC
         y/AryP656lUrImGflpaYmHPTMMLhEXN3IZiEqyNSb5D3zy6/cE89kHgb3EKpDL/6hhr5
         8jV+ZWFYGA9nZa6Ul2mFtESM/yxW6rnA6q+yoVK1nYP+FgB76T926MCHJG2PGQwxRSTV
         3gJcldwmUjZVuzfskQkwYUAvZFnA4Ah8SBZEXgiXRW6nml+ybZ5qlAMLgrPqNcyngNLO
         1lUSTnWhHixma0K5Ieb1cuDRN9cbecCVnhDre83cbNuAnNxlkSZB7BJ4Yyhtj8z/Dk3h
         H2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773653757; x=1774258557;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gseK4icojgYbBuoL5AHgGpLJevZBa1SV0g5b00g6iUM=;
        b=S2r4wKx1Jz8QoWjamzi4vcp01AwbB0nNr8B+T43f3RIYJrYnlI0QZDxL6UfNraztaJ
         rxqpB+JKQKslfkTmcgxWmhZmFxkbu1dXRYGZY3Kky+QUfjYp88Q/mcWJvggl74P+yCRB
         UnBUQx59nH19OzieEosNqA35kh7Bv0fHA2NSXT0uba4x9kfrOwtSllwYX2sCxxbR1oEm
         H6/F5P0N1v4fQgu7fwuuPXgYVEHKIRs5NLMHGyQn+Ayho30Ck1F3FgsXQfa160C4xnPx
         qOwRrIdMPaBF84MF9v+eYhau54uVL1217KFul19ZCsW2ojTaaegpZled+/fRXz4T0Mxx
         cZ9g==
X-Gm-Message-State: AOJu0Yxv5Hk24/ZaulKL+qL6QlWS644IvXnDclE+MEpAZOsWMFUjSd+2
	MH+AvQ1gbySiuoYCv2vP1jg1HiOuRkSCUzJjOz9Vzii/J3pCAB1vi4ni
X-Gm-Gg: ATEYQzwgVZF379mY6HM9kYwDzcq4+v7jDdpM0JxGp6hbWTXG/NZCFxpOQvc+sSm2w6k
	O0YxdGkHOSN616tK78NoVy4TmnKCojVk1PgXSxX2t+NqoJTv6MXyaArfNkPIdXDxO6svIN7UD0t
	E38mbPcLDTOBYuYPfV86nMviZ6klTJpac5WUFU8xEjZFwPfzyX1ebILSZKLTer/Ei0LfeJdKs2c
	paDV5GfT1hJQLBSMyLThMLn2XYk337hINIoaGfSEf0tn3GrHZm0XLUJz2QnBqIzSBTjXD/p+s5e
	/0W1rzdTjnPshnwOMf/KllOfcnY1ykGcPCvyXTTHvsKGvWRRQsjMeU5h2Zw3OPg7mi9IZtqygR/
	NrJG4TzIXYXUr1GK6ptd+UUMGy8nVqjNukv0OsT+jrlcld4EYXJuAz52heMNMsdN3hze04gXZfK
	oThubwFoFtKjPO9WhaKSPf4FPw0BKFAFYKaCE2wKE30w==
X-Received: by 2002:a05:6000:26c3:b0:43b:44e6:6e46 with SMTP id ffacd0b85a97d-43b44e66ec6mr3691884f8f.54.1773653756733;
        Mon, 16 Mar 2026 02:35:56 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe226473sm41019061f8f.32.2026.03.16.02.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 02:35:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Mar 2026 10:35:56 +0100
Message-Id: <DH43S71XJZBS.1C40IOTKEXO6W@gmail.com>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH ath-next v2] wifi: ath12k: avoid dynamic alloc when
 parsing wmi tb
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Baochen Qiang" <baochen.qiang@oss.qualcomm.com>, "Nicolas Escande"
 <nico.escande@gmail.com>, <ath12k@lists.infradead.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260313113831.3053586-1-nico.escande@gmail.com>
 <55358f82-f0ba-4671-90ed-8061f6ffbabf@oss.qualcomm.com>
In-Reply-To: <55358f82-f0ba-4671-90ed-8061f6ffbabf@oss.qualcomm.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33290-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD13B29718A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon Mar 16, 2026 at 3:27 AM CET, Baochen Qiang wrote:
[...]
> or alternately you can define ath12k_wmi_tb in wmi.c and add alloc/free f=
unctions in
> wmi.c, then call them in core.c. this helps modularity IMO?

I'll add new functions to wmi.c and make ath12k_wmi_tb static to that file.
>
> either way works for me!
>
[...]
>> +static int ath12k_init(void)
>> +{
>> +	ath12k_wmi_tb =3D __alloc_percpu(WMI_TAG_MAX * sizeof(void *),
>> +				       __alignof__(void *));
>> +	if (!ath12k_wmi_tb) {
>> +		pr_warn("Failed to alloc ath12k WMI tb\n");
>
> generally we don't log memory allocation failure

sure will fix

>
>> +		return -ENOMEM;
>> +	}
>> +
>> +	return 0;
>> +}

[...]

>> @@ -9215,11 +9127,8 @@ static void ath12k_wmi_event_teardown_complete(st=
ruct ath12k_base *ab,
>>  	ev =3D tb[WMI_TAG_MLO_TEARDOWN_COMPLETE];
>>  	if (!ev) {
>>  		ath12k_warn(ab, "failed to fetch teardown complete event\n");
>> -		kfree(tb);
>>  		return;
>
> nit: better to remove return as well

Indeed this slipped through the cracks will fix

>
>>  	}
>> -
>> -	kfree(tb);
>>  }
>> =20
>>  #ifdef CONFIG_ATH12K_DEBUGFS


