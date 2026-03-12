Return-Path: <linux-wireless+bounces-33113-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCTMK0/csmlMQQAAu9opvQ
	(envelope-from <linux-wireless+bounces-33113-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 16:31:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6D927481C
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 16:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DC1C304DC83
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 15:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8CA35DA73;
	Thu, 12 Mar 2026 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DB6URvQV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943003845A7
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 15:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773329182; cv=none; b=g4nlVL8B99yTM5hcBTCXwvnUtrY9J5TCpjlwspEyRwuJpN2k5TdMrSWUip5J37VIYj9r+x7q/tKW00g7j2hO4+HWQBsrr2GCRDIFZXYPb+HyaPhYGk027c/Lj+rvresxIzD0v/m8WkDgSwkAreE46p0BanTwfKqugmWvcWsmNOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773329182; c=relaxed/simple;
	bh=a1s16tfZgscWKEF4z5FxxF9nmjEgp3xGX6fU5ouXm3M=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=PrHwu20htQz+E3xvUZ0JdpfGo8OJg3lEaDH+dOdC5peDUuvRrSwMe7WjX7DLJCyUvBzQnxlQtKzKMSNEGjI/R5/KYGfFSMbX0T+5WRxg9XFkAV708rcIWxUn1QaaQV9keiiS8wjlN35AOqPQR56ihZJ6CHS1FIplUil1JHvZrlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DB6URvQV; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4852e09e23dso9926835e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 08:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773329180; x=1773933980; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmxvI1SLG5cByO9nSwPYtnzFrEf/m/FI7xQbZ3puZxc=;
        b=DB6URvQVXTpmlKFog4L+Ru8boV0r1BFlRbzFHnety4CQ0qkBsOOh0YjuKHwOcCaIlW
         PLcK05ewwlLrLs34FO8tBd+FjhgFtpZLPM91UEYYWOwoJwYKiFkaVSzRyYzBo7VSpfJj
         QousTvYAmVw0t85X5N1BO0+15JHtnX0VkLXTgBOpsKue0kYkW9buFnAegd3E+eBgVqwn
         N0/UerQVokjrCRux0k6jqglQHwvm3i3UpMq713e5Tfj2Z2UYgjwGLVCUXu9C0ebCXKjP
         T3fI2RsmOxNHyd6zdrm7oNZh8PZ4lR73f9Z3uRiJyWqiUgberwS8Oe2EopFwrm5Pz0oY
         Eu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773329180; x=1773933980;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KmxvI1SLG5cByO9nSwPYtnzFrEf/m/FI7xQbZ3puZxc=;
        b=l8WjhVZaqVSOH6snaDDhkUeaXIwlxEIE2jexz+kozb6/CRwuBK3HhIo5VUv4/Gybzg
         tMqbVwqUX1pJfPt92jRPfDlRWsKKxwWNT474WPr6xKmSWnUkIcG3rJUkGtu3ZQH790F+
         6tDVj12c5b3iNrCQR/1XAXfNsnkDWUjr0gHAPyDnwt/0/Cx1qvI/yYuAK/+7YIegvB/O
         ye6+Vffd2D8zWt96KDtO661pbw0HJ7Z+Sx8qqUo0thKZCzQE+SE8A/fbcHaL8xinbOEi
         03VmqDGTbRZNY3hu89/xCQ5GkpiZUSqBV+bl9UrvwmmqgAcRcCOE76F/ktp1VI/S9pmg
         hLHg==
X-Gm-Message-State: AOJu0YytZuYm5BQ7/U9NjyMskeNg4BcwtLNSuxwcNBWGTvMLt016rCZn
	DME4O4lj1PAUiotsdAAT7Ejx/+v8MK4g+E6eBvzZ7ojLwdIFzjb+BqcH
X-Gm-Gg: ATEYQzznbL2N3Uax+l3g6lXxd0WdGrQbF+INHqMxM+ca72IqI+2H/MUkFcK3oQrLU7x
	HQNPM+2H0iEEOaa5/HhfSULCoYNi6G2E8OSl7z9xdhnP7kYhN5cHPe5R5a7ng4ETBuCz3yoOreJ
	Vl3iL6gxfjI1Rx1/5L9fYZiI73kSkF+InjBa0sn4aH33hgDNfadutKCkRhJutAUblgI578HD8Px
	otF5zP2PmBDvpv1VxevaO/GXV+pN/CJxExNU1LUEs+zKsxGXY5M3N5E8JRSK7ndTcTY+Gd63eMt
	4PabHzfRsGMv0I5sjx3uAnUGoHeQSbBORvWH04v9vxeN17m4tG1c+RaquGgZ/vqjPbEhwOTGokm
	tvZFOnIAjcrBleQWbdyJ/xYz0c86FRM3dbDDzVlN08YOs+Y0aszE1ncPYgSeuKuRD+816MFBBIZ
	J6S9ftBbhPAON0X7LnlSWZWBPk1HwIHy7l/TGuvBBQqw==
X-Received: by 2002:a05:600c:3e10:b0:483:badb:618f with SMTP id 5b1f17b1804b1-4854b11694dmr101953265e9.25.1773329179659;
        Thu, 12 Mar 2026 08:26:19 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b65fed7sm130000105e9.11.2026.03.12.08.26.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 08:26:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Mar 2026 16:26:19 +0100
Message-Id: <DH0WQAE5UP5T.3ND14AH29KR8A@gmail.com>
To: "Baochen Qiang" <baochen.qiang@oss.qualcomm.com>, "Nicolas Escande"
 <nico.escande@gmail.com>, <ath12k@lists.infradead.org>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH ath-next] wifi: ath12k: avoid dynamic alloc when parsing
 wmi tb
From: "Nicolas Escande" <nico.escande@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260309152050.191820-1-nico.escande@gmail.com>
 <04d268a7-8f6e-4aa4-b366-0dc38c355de7@oss.qualcomm.com>
 <DGZ17385SNYX.3149KUG92UUU1@gmail.com>
 <adcb0245-6514-42f7-a47d-f6d8b3f79dff@oss.qualcomm.com>
In-Reply-To: <adcb0245-6514-42f7-a47d-f6d8b3f79dff@oss.qualcomm.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33113-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E6D927481C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed Mar 11, 2026 at 6:46 AM CET, Baochen Qiang wrote:
[...]
>>=20
>> But if you guys don't want it that way, I can rework it. Just tell me in=
 more
>> details what you think is the right way and I can modify it.
>
> then how about adding module init path to ath12k module and do percpu all=
ocation there:
>
> in ath12k/core.c
>
> +void __percpu *wmi_tb;
> +
> +static int ath12k_core_module_init(void)
> +{
> +       wmi_tb  =3D __alloc_percpu(WMI_TAG_MAX * sizeof(void *),
> +                             __alignof__(void *));
> +       if (!wmi_tb)
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
> +static void ath12k_core_module_exit(void)
> +{
> +       free_percpu(wmi_tb);
> +}
> +
> +module_init(ath12k_core_module_init);
> +module_exit(ath12k_core_module_exit);

That should work, I'll try something along those lines then.

>
>
>>=20
>> Thanks

Thanks for the review Baochen

