Return-Path: <linux-wireless+bounces-38533-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jIYzNsPURmpQeQsAu9opvQ
	(envelope-from <linux-wireless+bounces-38533-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 23:14:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A647E6FCE4D
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 23:14:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Xc8Z9FnL;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38533-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38533-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB385300440C
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2026 21:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E9F380FE0;
	Thu,  2 Jul 2026 21:14:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5088530675F
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jul 2026 21:14:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783026878; cv=none; b=FZZzqAVb+WCyVEmYt+j01aN870xWYHKMqA0YIGhMP8k2RAYlz8rEhToBduNplIqoF6U4icvxp0JqvyG1WmnDSHSCGEkbiNTJ6+72Je/fH7hVHjzWRwxDSd47fTy8TcHINgeHdi216PO/Mp+IIfXJ/XwXQa63HCXKCVYcsteP+ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783026878; c=relaxed/simple;
	bh=Pn8Q5FEznthIsWHNTelr9V/QR8SNMi0p0712+cI0p5Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=uyMEc/nUbMGy7p7i29AQxuyM97Nlf/7UndAxe6mnsFBz0C3FbQGGZJ/OdBLHAUzgEHDw6erV5P2LVwFfWgNnqarSfTfOy0DYl2xL3lE6yIrvG4yHu7dmMNteNcMIzoi4BrLuJrptBEGXOH118/FjEfjAaSfP0zQZkuCyC6mOUyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xc8Z9FnL; arc=none smtp.client-ip=209.85.128.54
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493b7612475so19525925e9.3
        for <linux-wireless@vger.kernel.org>; Thu, 02 Jul 2026 14:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783026876; x=1783631676; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5xNoEqWPKSku3siZxSBMOiC0vCdU7+eyeCETDkmLM8=;
        b=Xc8Z9FnLY37RkLkEuUn08WBlq4WqHv4snYzyk9ljaTi00z1bmMWSGW2u9OH9Z6jOO5
         WTDCstZh3NqHt6GCl+OLBDgtAj23zZllEG+oW9EQIh5tT0bBSJc6I2a28DAZt5J97rIk
         SfGRGp2lRkaYd9kF94irDTi7mji+5sMfgXz4dJUEyE0mpEBbKSRdYrRFWkuVYEAbPrBe
         g7gXlsni3Kd3jgC4XqwYMw5z3oXUcs88EVR0JmcDYee//FIlMDPQTTgONQbPvFPkcJ0h
         yTJR+aNvjEZDjxIBSJW70meX3bcmonwc2UedpFCB49Pp+LE7ILl6w2RQ+3EBzcTbIEbe
         qcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783026876; x=1783631676;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d5xNoEqWPKSku3siZxSBMOiC0vCdU7+eyeCETDkmLM8=;
        b=lIwsQtIPrer8d7sgbcJsED82CCW5a/XdugHGvBgCRWmezVkpkM72rxHAO3A8RQ0+JW
         d3hHO55WTXmSUEbTYrU1ees8F2n7xt8zgyWBfFU+Ifbb++32KmL8OMK7hpQZONfOZeXw
         m2qdpwWMiPJlze1Gr/60YF7C3W078WXlTX+ByqREs5Dz+E6Fv5QBR/xa1QmCGonXP0hj
         8aXGvLHnxtoNZvHhFfyktJdU+8tj2Zs4d0ff9upCywbYk3MZpHQqOtWx8ihlWaz/6tI0
         jkETCRYBgF37XHcqdFejQwbtzqnh2zxm/Ic0Owz8sEzu+PH2jDlYTb/5nac2cTaldSUN
         kwUQ==
X-Forwarded-Encrypted: i=1; AFNElJ/RZgNKUP0P3fzKtVVO0dq63dpf09pfJ5Y9e7IeFJoDNj4V48AMSNbV4hPLYod5rnmrHFy3mqqV/17k9DZAww==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrSHxzMVzbMPj+hnRf9wlQhSPzTn5jG9laEj2tIYna5zYtZZrq
	4kXBYWg/Cm4jN5LDbFr3lv/qh01LaYR+E9tTuT3X/9oY8S4B/KhY6bwo
X-Gm-Gg: AfdE7cnsrD/5ySdeBUrKLAl85uVCtQ1EJt6HZXjunAUHvQvTMrcogNJgtbfF7ID/Izo
	h9Af0QcEZ5aomLygXEpvzeXiwE258sT4/Puen1gzac8u31N0cUtjPCysSYzayHx33Y9SkWCEst0
	tyv+igT6S9FDHRUrg9Fb/nk5wquwKblKhPYrT67bb9ITbpFG6hC0UA+4uWpgV0ymyeUA5FqUFed
	tk8SXGre5UPFwGqkhnrL7446lWpRVOzG38bqnBa3loCsyadZhiSlkub1cw6puiKAIFBBNU+QJwh
	Y0CGQnWXM/f4vmoPMvmORzWnGzW9n/Fyppg6+oonktXBTyimBs+Zy8QlZikizX8wMR+73BQj6Nj
	b3QKvmVNVP7Q4ME4F67oAcsMb+Q50YM2tF/VHoXREtAULT4bfchffmG1KRs+2hcJYU0aifCsUAu
	IA1JI6teNGlbLqF20TiuMpyuGw4yT7Cr0=
X-Received: by 2002:a05:600c:1550:b0:493:c389:d434 with SMTP id 5b1f17b1804b1-493c389d4c0mr100403525e9.15.1783026875554;
        Thu, 02 Jul 2026 14:14:35 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63b6f1bsm69320955e9.10.2026.07.02.14.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 14:14:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jul 2026 23:14:34 +0200
Message-Id: <DJOE9Y6P3ZOV.371FAU647MOYR@gmail.com>
Cc: "Pradeep Kumar Chitrapu" <quic_pradeepc@quicinc.com>, "P Praneesh"
 <quic_ppranees@quicinc.com>, "Sriram R" <quic_srirrama@quicinc.com>,
 <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <kernel@collabora.com>, "Rameshkumar
 Sundaram" <rameshkumar.sundaram@oss.qualcomm.com>, "Rameshkumar Sundaram"
 <quic_ramess@quicinc.com>, "Jeff Johnson" <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v2] wifi: ath12k: fix survey indexing across bands
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Matthew Leach" <matthew.leach@collabora.com>, "Jeff Johnson"
 <jjohnson@kernel.org>, "Vasanthakumar Thiagarajan"
 <quic_vthiagar@quicinc.com>, "Baochen Qiang" <quic_bqiang@quicinc.com>,
 "Ramya Gnanasekar" <quic_rgnanase@quicinc.com>, "Karthikeyan Periyasamy"
 <quic_periyasa@quicinc.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260702-ath12-survey-band-fix-v2-1-75b5bdf72a08@collabora.com>
In-Reply-To: <20260702-ath12-survey-band-fix-v2-1-75b5bdf72a08@collabora.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38533-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:quic_pradeepc@quicinc.com,m:quic_ppranees@quicinc.com,m:quic_srirrama@quicinc.com,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:kernel@collabora.com,m:rameshkumar.sundaram@oss.qualcomm.com,m:quic_ramess@quicinc.com,m:jeff.johnson@oss.qualcomm.com,m:matthew.leach@collabora.com,m:jjohnson@kernel.org,m:quic_vthiagar@quicinc.com,m:quic_bqiang@quicinc.com,m:quic_rgnanase@quicinc.com,m:quic_periyasa@quicinc.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[nicoescande@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicoescande@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,collabora.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A647E6FCE4D

On Thu Jul 2, 2026 at 12:50 PM CEST, Matthew Leach wrote:
> When running 'iw dev wlan0 survey dump' the values for the channel busy
> time have the same sequence across bands. This is caused by indexing
> into the ath12k survey array using a band-local index rather than the
> global index passed by mac80211. This results in surveys for 5 GHz and 6
> GHz channels returning values from 2.4 GHz slots, making the survey
> unusable on those bands. Further, there are redundant survey slots for
> multi-radio/single-phy instances.
>
> Fix by moving the survey data into ath12k_hw so multiple radios under a
> single wiphy share one table, and index into it using the global
> mac80211 index. A new spinlock in ath12k_hw serialises access to the
> survey array, which is now shared across all radios under a single hw.
>
> Band busy-times Before this fix:
>
> 2.4 GHz: 9, 2, 2, 2, 4, 2, 10, 16, 4, 12, 5
> 5 GHz:   9, 2, 2, 2, 4, 2, 10, 16, 4, 12, 5
> 6 GHz:   9, 2, 2, 2, 4, 2, 10, 16, 4, 12, 5
>
> After this fix, times are independent:
>
> 2.4 GHz: 23, 5,  5,  12, 2,   12,  26,  5,   3,  1,  27
> 5 GHz:   30, 40, 29, 27, 118, 118, 112, 120, 11, 11, 11
> 6 GHz:   1,  0,  0,  0,  0,   0,   0,   0,   0,  0,  1
>
> Tested-on: wcn7850 hw2.0 PCI WLAN.IOE_HMT.1.1-00018-QCAHMTSWPL_V1.0_V2.0_=
SILICONZ-1
>

Hello,

I see that this is supposed to work on single phy device, but could someone
do a proper test to ensure that it will work on QCN9274 split phy ?

I know this is a big ask, and usually I would do it, but I do not have a se=
tup
with a new enough kernel running to test this right now.

Thanks

> Fixes: 4f242b1d6996 ("wifi: ath12k: support get_survey mac op for single =
wiphy")
> Signed-off-by: Matthew Leach <matthew.leach@collabora.com>

