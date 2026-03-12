Return-Path: <linux-wireless+bounces-33114-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJcQDHHdsmmtQQAAu9opvQ
	(envelope-from <linux-wireless+bounces-33114-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 16:36:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8C7274995
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 16:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8B84321B89E
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 15:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6731B382396;
	Thu, 12 Mar 2026 15:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OACLp9L1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E70234FF6C
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 15:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773329435; cv=none; b=ESB8velhyk8uDGihSJ41y3A5lpvSSic/FRoHX5taiZ/IhmyotVGxjAvo5HLxtopx6Tpebmedg/qoY3om1bQozB6fScM4UaAERITywC1oVGesrirTXT1LgkI0FchC3WpwM3aXt4WqKVGHImFeRJPxNoNkWdOfkU0wT0Re0FQz0A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773329435; c=relaxed/simple;
	bh=X4TwK9wYWrjLWfl82+wdKTQsnMykfTPN0ArOX0oxONU=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Sjrbs56nFOnOD1gJ7r48UYMGLyquQUHXGWz2sOAGr5XZffTWVTzstqvn33kIEOGt4e3F3QxSB8yKyNaBvM/ySdSmpSqhy3QBnIi8ty43eW7pj2vtaDIADMP4Kf59berGSrqykKIpHrJSCY72XEGsWwLyv54e066Z3XD4KcxMc2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OACLp9L1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-485410a0a8aso11033555e9.2
        for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 08:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773329432; x=1773934232; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Ya238d2ohp10iFYuWnPLzqnu0MMHEfPVLrPGoAibNs=;
        b=OACLp9L1SEjG29L01SoBmEtYK1J88lC6eoicjaXto+X//GB7e4uCikkzpG0Tl5hbVC
         A0e11Ki7YAabB6IyUGX03hzsH9ChEl3BnpCQvjdD/2tQSPKP2x4QnaYSGQlAmctGCuCL
         /HXNHwrfNAhuwcJIrU+GD/+I4rakOBIaLLzse8p4Pk6lcr7hEtQ00GN9tzsBye2Y+ppV
         6RabHKZwDAVMExx30LnVWxhfTrZsdwt53QXWb+fz1upbBmUrA1W0wQhVCWPQm9W5x8Kf
         PO179BJHXuWJNp0PFU5iYkB+qa1O/gTSorj70IULyXosMWpGDY/0fxqb+LpL4VFz6Ddl
         RZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773329432; x=1773934232;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Ya238d2ohp10iFYuWnPLzqnu0MMHEfPVLrPGoAibNs=;
        b=i3onG1YwLL4lDB22dXfLD6fgxcP1CLD8LIKdZ0qzprhyrn03rGk9Ihal3gi2ru5A8C
         PZGuHdtihXWcI+rbCdMHT8awaKOd6QtsksnnS/cRwjPrZgc6TZ5jVTne1FqimFnMqcDi
         e7N3hVxhM36OHOryq/lI3vHPDAQb/XmAxKWa532MT2hVzSHv1GH6OK+J4djRYt3K03Pi
         J1QUE2uFvl7rGe+M/y1d8zUyGf+47sqYPIS2jaaK0YrtrAnECay4W3isvLBsXyO2SZ7Z
         E1MFYe0nqMeslZVXcu3/4t/BoFtBhGKcM85Kzdhrndk+q6pbswl3Fkb/SIm8yR7ZOC6a
         7uVQ==
X-Gm-Message-State: AOJu0YzNfEAfvMOxMw199Pn9yfcTp7BNM+uL6MVvLsOtbIDRyYNRCNwM
	wzOlU2A5JwVIi/Cy9O0yT9Oq3QNppDoWWrJyJGDa4eSYx3lorIO0RRLZ
X-Gm-Gg: ATEYQzywAhERnySsgN6PA+2jWgCW0PASQ+y/v91cdSxeC4/fuBbmWLplYq1CZVofeus
	xWapYm/BRcDay039Cq5tc5torXfGWnsJ1QUolIju2HBmnbAdjaYg/T1AiFdVRSb5or2TkVDEFHS
	piuS4zgHHVBqIvsLM8L2Yug7jUw8QEd4ELhAe0ne+TIZS1NuuwAb/+7+f9ZxlG2mR4+QhJgKLEn
	6+9e+LB3Y+qVsH+7fVofT137Dhl3G6YpCxXFMaiNGVG9XI/t9uebL+o0Lm01Ky9TR0y2GSHVqTT
	3XzZvw135uBuAVTSmWrMG+gFEzLJUHMEeI++6hwwkl35OLSKRd/utyLm/fqY5bwPXi9aKM9++8l
	XXBhELYJtFkngzyj/CArIiRKYdtJnNB7nyB+00ofm1Jjv2k+H55P3gUg3bXJRw9PTA2pMQ4zCUe
	8UIk9uR7DQ8KuC10jdrFoy9xnJc4PfrwdCkDAs4UjBvw==
X-Received: by 2002:a05:600d:6450:10b0:485:38fc:7069 with SMTP id 5b1f17b1804b1-4854b1b1a61mr86890415e9.23.1773329432326;
        Thu, 12 Mar 2026 08:30:32 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b7f3cdsm265726375e9.14.2026.03.12.08.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 08:30:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Mar 2026 16:30:31 +0100
Message-Id: <DH0WTI7WT7H4.3TVAG9RAB1QX0@gmail.com>
To: "Nicolas Escande" <nico.escande@gmail.com>, <ath12k@lists.infradead.org>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH ath-next] wifi: ath12k: avoid dynamic alloc when parsing
 wmi tb
From: "Nicolas Escande" <nico.escande@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260309152050.191820-1-nico.escande@gmail.com>
In-Reply-To: <20260309152050.191820-1-nico.escande@gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33114-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicoescande@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8A8C7274995
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon Mar 9, 2026 at 4:20 PM CET, Nicolas Escande wrote:
> On each WMI message received from the hardware, we alloc a temporary arra=
y
> of WMI_TAG_MAX entries of type void *. This array is then populated with
> pointers of parsed structs depending on the WMI type, and then freed. Thi=
s
> alloc can fail when memory pressure in the system is high enough.
>
> Given the fact that it is scheduled in softirq with the system_bh_wq, we
> should not be able to parse more than one WMI message per CPU at any time
>
> So instead lets move to a per cpu allocated array, stored in the struct
> ath12k_base, that is reused accros calls. The ath12k_wmi_tlv_parse_alloc(=
)
> is also renamed into / merged with ath12k_wmi_tlv_parse() as it no longer
> allocs memory but returns the existing per-cpu one.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00218-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> ---
> changes from RFC:
>   - rebased on ath-next 8e0ab5b9adb7
>   - converted missing call sites ath12k_wmi_obss_color_collision_event()
>     & ath12k_wmi_pdev_temperature_event()
>   - changed alloc order & cleanup path in ath12k_core_alloc() as it seems
>     it confused people

And I just realized that this part did not make it to the actual commit
but stayed in the stage area. I'll add it in the v2

>   - used sizeof(*tb) in ath12k_wmi_tlv_parse()
>
> Note I did try to move to a DEFINE_PER_CPU() allocated array but the modu=
le
> loader complained about the array size. So I stuck to the per ab alloc.=
=20

