Return-Path: <linux-wireless+bounces-36684-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CEUDDJBDWprvAUAu9opvQ
	(envelope-from <linux-wireless+bounces-36684-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 07:05:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A024A587B0E
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 07:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 095CA300B54E
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 05:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBC527E045;
	Wed, 20 May 2026 05:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSZqdtlw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A321C36A356
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 05:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779253551; cv=pass; b=n9mz4IusRJQLCcyUOmwcxD7tUCpdXxMaIP4jf/YgNWjWYHR4r5vfv2WMTN4EWeEOqUgcXBHPTgsYtP0O/0vIrQggnljc0+HFTRvj4x6qLQ1wcnZIjZ7SaW1NY7ggkgrRfSEIGthvKc8Y4u7lgTghbx3ZnnwU9cQoNmP1HxhCd3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779253551; c=relaxed/simple;
	bh=2oT1OILHGrXHSa/hR9MLrEmfqatnXBxBL1E4kcjbSJ0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xcv8l+7ZYQk6mgKfYrtXOiEIc9HNp1uyQ+RFbU286Po6UgpMBsdtGiboCx4MqptW8QwdBL+HlEP+18Sq2FL1PAql7jrD5qG+BXi8HPBa2dtRlbi+CM3dCeBTTFXzyG4g8X0w10H7qWcKRkLnPOlF6bu5TKLM6vC2mD2mOKCGFV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSZqdtlw; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50faeb8317bso40844561cf.2
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 22:05:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779253548; cv=none;
        d=google.com; s=arc-20240605;
        b=SW4IRkb3d2lAl12Q8GSkeZgJmn8cyA6fbC3IdtY/0AqNWtba6kOm/OrEA6Toe0A8CE
         0XOY7ltRXRTVbEIfVFc3azQ4iURjK0rOD0zqMVej42U1eGfT+uHsZ/VDInyuePNGRoH1
         rDb27NYzK+0yRhFKV6onwH/toQgmC50A1g/gZQAy2VDCtPx0aoqBy1SkQGc24D8Rdtwl
         GfNeaFbQnQ0vs9Cc48ByhpsULwxupJ+x7txWK5iCgEfC90TbgH2uf9fMRMSlbnywvJXN
         mLtWbLkT4GCxqhjmocN1yj3oZjyIU9XsqXzqzQHdaPJqrMVWucMiNIZV6CU7GIHiJXxB
         BK+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=mSiwQCogWokNb1E8QEhJhk/M4DdIyPHBuO9qw33NBag=;
        fh=cVIsshAbEsu3UysEhwiRIO3rrNhqyWQGJ261XePYPmc=;
        b=Y4FpJnBTM4CWrFhpH0d71g7z50twCvDGQpGDTF92zTtlQfSEHgPal3AMuVWQJ7ScAn
         eLAZnoAyYOmbsdNQ8EJS3MoHXrqXECbV3NHA/SH4k2QIpUIEzAtUq744dc19XndUYJ8m
         ++9A3Whm36rIpE7KQwc/yjExfD7r6ru6FIvKf3eKQYO0/a3WfAJOibdOzeHkpbzs+jDD
         XlZyIENDILZGni+4PR/kcK2LOweZ9UegW+Tbq9XuExEXJ+be80pKBCgiOtINLNvENIAc
         7aXzKu6NjP5yYkrdIYF50/x9wV55WJ4bm7JP0PoEsSQhisaodOAhTI14LybPSO3GTkU6
         dgrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779253548; x=1779858348; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mSiwQCogWokNb1E8QEhJhk/M4DdIyPHBuO9qw33NBag=;
        b=hSZqdtlwvHogY8a0KZFo8p11/sevfOC6g26iZzgDVkJKaX89gqzBB554VTPoa0pe9z
         ATeVZtZDsDwUSFfLzuMeXXC9aFMPBD0Qwf0tgfvdWTYeH8blnFAa7GkfKLvQx4JWlEAC
         2tavnfh+ENbCW+ySBxwq5tW+4HOLY7aYwxEVf3v8I9u55HwJhVhCQXnGobYlo3WDbuIP
         NVRtKovEID7INpBdR7nKq9vjW2MxHIEs2KZc/nThmxHX3Cq53icvyPR7xOD1ousH7MJi
         n31w30/zupBtzfuRXoy+aCuqSqUSyBG/xv9ZpZqHRmBTinUy39ZQ0TDOtvCSqtcZg7vA
         fPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779253548; x=1779858348;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mSiwQCogWokNb1E8QEhJhk/M4DdIyPHBuO9qw33NBag=;
        b=nGh5xB3YjWmPBdjUwmSRg/9+Rn5VtlwK5hWmKSqyx2sf8iAPm8LMGsvnkm3dkLLG+a
         IjyRCZDfyUXIKxSC2W3qV7TmtyCzRXvWWWM3tomJiD2OwHOgTvOntaocx4C1J47DpkpP
         XZdH/fhImNMPSshZiwK6kPZZ2XDjHIHibhqywB3VXK5YL0j8o+S1iSAz9Vf2R8mYJHEl
         AGpQZEZa4zwYeXQJ1n/57iTWIf0fkZFlEPVUVo3QhkDY5h5KjoD3ztnMnbNtE3kLounV
         7ParkIGzJYZsLaSTiDf7HQ603OXS/TIWSAqIVBa/KGQasJsIYet6MJ+Uaj/VqLvFbX7z
         kYDQ==
X-Forwarded-Encrypted: i=1; AFNElJ91A93nFFsY4PTQITusnhBdn98PJK1UO86cNRMx42Xql9WGMivwLT8JVQwyeapiQnz4/x6EGUoKo5tya3r0vg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9hMNxZtKtRHLOHxVhkkcnH958Ie9FjfYUDBSQyzkM+onKBM6u
	rYMckBYjz5Oyg/jwZ3c8xuiMAsWQ/5tNyvi0+vXeQPcy87KiS6MNi/S2nczzSeD1gTYKkxuKWWK
	NaLaiXix8RvCWF8yTh3wbn53KdyYTBLc=
X-Gm-Gg: Acq92OGY8NyhZLnNBk6B1xcAgHVLiQSg5K6a18ma7sfWHU8gszCXCHK8L+fDfvTm3zn
	lpTAHz5mEyUL6Y0c9XcZnWbtuqviMxV954rkPCxUdW82pCHEoj159F7DzhLSD3PgT6F0HIlVW+U
	pxOLxk9VnZaCdXy8fzEwTbxFPpWHwGvoCTs823bHXUX7aKp2lHBc7BINykxknwFWe9kHYI5z3uC
	FfuOYpt1GI1RTK5UkUC/jyTZxI7xi1BTVZpV8f4mRi3vCPTxdIdnbykRRv8JHHUguB9pNy4vmP+
	Ca/S
X-Received: by 2002:a05:622a:1814:b0:510:1463:4fc3 with SMTP id
 d75a77b69052e-51659ea7362mr306840581cf.0.1779253548355; Tue, 19 May 2026
 22:05:48 -0700 (PDT)
Received: from 1074302158857 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 May 2026 00:05:47 -0500
Received: from 1074302158857 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 May 2026 00:05:47 -0500
From: Stefano Ursino <insalata.fresca@gmail.com>
In-Reply-To: <f2ad69a2-35da-4611-9466-eda63c264c1f@oss.qualcomm.com>
References: <f2ad69a2-35da-4611-9466-eda63c264c1f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 20 May 2026 00:05:47 -0500
X-Gm-Features: AVHnY4JYfgVmDMXogroHIh0TFlqbt9TPSPb4Kq9wTruVwydVDhB8Fluofdc7Df8
Message-ID: <CAAepT2Su7dQL__DpX0JUwtErW8nedxTcmXEkZqyR7DU-YWnvRw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_ath12k=3A_QCN9274_hw2=2E0_single=2Dband_cards_on_IPQ95?=
	=?UTF-8?Q?74_=E2=80=94_firmware_RDDM_after_WMI=5FINIT=5FCMD_=28WLAN=2EWBE=2E1=2E6=2D01243=29?=
To: jeff.johnson@oss.qualcomm.com
Cc: jjohnson@kernel.org, quic_rajkbhag@quicinc.com, ath12k@lists.infradead.org, 
	linux-wireless@vger.kernel.org, quic_bqiang@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36684-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[insalatafresca@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A024A587B0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jeff,

Thanks for the pointer to Nazar's patch and for pinging the team.

Bugzilla #221550 was filed shortly after your message:
https://bugzilla.kernel.org/show_bug.cgi?id=221550

I see you have since assigned it to Rameshkumar Sundaram -- thank you.


Fix B update
------------

I read your May 11 review of Nazar's patch [1] where you pointed out the
zeroed-slot problem and suggested a compact-array approach with a separate
write index. I have implemented exactly that:

  - write index j (separate from iteration index i)
  - unknown module_id entries skipped with ath12k_dbg()
  - ab->num_db_cap = j at loop exit (no zeroed slots, no free_dir_buff:)

The patch applies cleanly on top of current ath-next. I can post it as
[PATCH ath-next] referencing Nazar's series and your review comment if
that would help move it forward.

[1] https://lists.infradead.org/pipermail/ath12k/2026-May/009267.html


Firmware regression matrix (Fixes A + B applied, 3x QCN9274 hw2.0)
-------------------------------------------------------------------

  WLAN.WBE.1.3.1-00162: stalls at 'failed to receive default regd during
                         init' (regulatory timeout, no RDDM)

  WLAN.WBE.1.4.1-00199: no RDDM; 2.4 GHz card (board_id=0x1, OTP
                         programmed) reaches 'ieee80211 phy2' -- driver
                         initializes fully

  WLAN.WBE.1.6-01243:   MHI_CB_EE_RDDM ~316 ms after WMI_INIT_CMD on
                         all three cards simultaneously

WBE.1.4.1 is the clean reference point: the hardware and host driver
work correctly, the RDDM is a regression introduced between WBE.1.4.1
and WBE.1.6.

Thanks,
Stefano

