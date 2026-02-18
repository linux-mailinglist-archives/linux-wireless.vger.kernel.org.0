Return-Path: <linux-wireless+bounces-31988-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IN/pJVRPlmnddgIAu9opvQ
	(envelope-from <linux-wireless+bounces-31988-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 00:46:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DC215B00B
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 00:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA71430075D6
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 23:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C8E2DCF74;
	Wed, 18 Feb 2026 23:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ky/JtG2K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F6D24729A
	for <linux-wireless@vger.kernel.org>; Wed, 18 Feb 2026 23:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771458385; cv=pass; b=OiyHf+7x5j+vIUC/qhSTaRliy0CrdPrcR+aIFOD9AuO5iNjbPAmjr387NpcyuXdlxuHWGSM//Dao0FM6W7F2JdpnpC7DKFK08Tb5nqBYE0fLjRXLmhf0wm5dLDbg+BQ7h4iiBmJHwifuf9mY+IPs3cDzdwm+cWNNOp+V4HSFwHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771458385; c=relaxed/simple;
	bh=nyeF6Syp58wpAX/nSQMFPOFSiOCLnLcVMClZOGIvtMY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Nn9bwaVt3vTqMBjl3nT7Yd6lcNc9dJzdzoGD7oKuEeZ2u6S9QtSihpNOuQXKqwTqUA0e/NlhnVM1sy6V7jsliZBhC6i9xTHgWvgEIeUU3OmBsusa2FjfO1EFI55te2E0mtqzHu2ko29L6t/OA/R6CJQn0JaY3YFhRAy5BiCqPTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ky/JtG2K; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59e60b3ccdfso713725e87.0
        for <linux-wireless@vger.kernel.org>; Wed, 18 Feb 2026 15:46:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771458381; cv=none;
        d=google.com; s=arc-20240605;
        b=j3L8b28uRrpCpm7a3P6KPd4IguVEJI8aDveh2YyuFU6BAiEToK4iviieF68mfSUJ/P
         Xy0FU+JlwrLM39wwrGcPddH56A27RvstDicUFXJpqNFubUVCtZwutnUHNpYZqEr0APru
         With1PYMsfhZHnK924UTxHUrDDkY5rrtnEqAQFEYiKkMgIbx96RfBnzY3oZPcBwgC0e8
         ulYBa6LQ9fJmBKtsnechfMLpnGENjrzrhKd0IaHuU19K1EzT/3EtPWHS+W/Dv0iO8AH8
         1i1KSY3ImwvxLflTiK2XjgaFIEaAgoUMJzTE1Z11dp1A9UYnTYvIiCr1tFrTOi93xFc+
         VAzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=QevO98KHLWcbX1UYHC/TyN+Xu4jEc2l88zPuWuuNFBQ=;
        fh=qW0phhq3fb3oiohK/Mu9j1KY1zyRNiiioKFc5anvatM=;
        b=ZOOUYvy18NTUa6E3dxOykKSxy2bidFzRvSdiQecyy9JdVIXPEyOpOf2hgtAn9GNUaq
         dNCOgO6oSgeXx5/GUv1N7bb1jjUOkHRwyembgj27MlzKh31yrZ/taY36vylTK+KnPy5N
         3EdBBG5Fiehc7S/vm/p7soIzta6kwtUY8XTA6KPuXCvcx+OVPnlQMO7bXXL9ywGuCy5U
         z+ZtafGm4WQ0uQGLH+MMV5IMtO0dCGVQKSeafNLL6nLDgzyRpuX50tJYoFfh3/K3CIs6
         1O3hE4BYIQEuaws2IU8GrTNlmmJGQRZZtLAdAThy8Iuj8/bjh9B2daIf7MzPLyIwUnlh
         jCfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771458381; x=1772063181; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QevO98KHLWcbX1UYHC/TyN+Xu4jEc2l88zPuWuuNFBQ=;
        b=Ky/JtG2KSTzWgrT92SkgTh6W6AHukchLKEQVxSup7HCEwz94gELzbHtXMgwISBpjiM
         gnAJ0UAqdGZEViTSL2/8sCs+qYdZbqKZU/hIis9TvpcG8dV2Wrd/xvW2JHlSa3pnMzFs
         Y0VAf/aaNeK/bs6IgvNsVOP8zAZNH19Leam2OJD1sHvScQW8gpM9UnAzO0S99O3Wkjzf
         heObxM1MnHYoCSFoHo2kZ4bwkuFNU2QHCigyhT/NF9YUo9LmzQOyyFAtl636GkDCb1kN
         6i8Pg5cXZsp90YWo9u2JDfUVZ9xHU2av6o/4uX3mG33JRhqhKCa22JKjpYPObgGZAfze
         s+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771458381; x=1772063181;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QevO98KHLWcbX1UYHC/TyN+Xu4jEc2l88zPuWuuNFBQ=;
        b=elEOT+sGBjySFgF39bDuSNSNJHTqd69a5nR1t1weF6lsRtrW84kERJ1Dja5myMpZQ1
         p6mNvTppfpS+v166vmKKLdvZx9rU+kvmh5Al230XghKj9Di1SoMmEn3LcoKz+fw0izpQ
         1bQ0rEO4qYFp75gT0Y8yTYMPdLWw6KC5PUj5JRFNQ3W1X70AMDDNgLLq9Z9k8cH6zuti
         Qm/sIAGyZIMU22H0gfz9rnNKyFbv9z1jQHTwFTwhRQU+CmPBvxIkuFfnPjXuZAyz4Q69
         +99XDSRVzoTxCeV9NAXCvus9KlVPHaNxDxpz/hcQYkN3SHKAJmAFtbhVOxlFvrgDUxo5
         Dcug==
X-Gm-Message-State: AOJu0Yznjf9KN0bVycVosVaj+nCwjTTCJtn64pHmCjr0Pc90wL6zxlRx
	7mCegRdJHF6Y2v1xQJBI7udo3E6y62X0Qe6PCoTFwRCUTHRRf6y7EmLgCm4bT7Bi9CDM18XrhnP
	iob6AlwKRMXgJryftoykXPM06To1w6c9c1buU
X-Gm-Gg: AZuq6aLpsMMBKm3XWwSprOzNcQpv+hLZevfLaAT0niAnwdqj24+JUZOi4puEOwT7UlA
	1XJf/HjhHUBlI9rxMuBOwVjKN7uYmfiTMt5dmn8wdJgK56QTFAuY+fil8vbYHOXtcp+wYUSwQiH
	V6JV6rcTZRZWRS13QSpHbvj1BU/i7kmz4MAogEGQAfTED1cgDF70HmuMIGVbooB6QIgquffI5S3
	CXRxBY5thVpUdY5U6aDFrxNZXfTxvqfqavNTj9tZarVbwPo2zYqRLlmAEaztr4Qixa+BIiYvU9/
	U53az8ZF
X-Received: by 2002:a05:6512:318c:b0:59e:aba:d193 with SMTP id
 2adb3069b0e04-59f6d378689mr4978446e87.24.1771458380949; Wed, 18 Feb 2026
 15:46:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Brandon Parker <bparker8686@gmail.com>
Date: Wed, 18 Feb 2026 18:46:08 -0500
X-Gm-Features: AaiRm53YtY7OS6sR-iglrQXyJFavmF5gl7JZzy33M7sCopsmvazkaH3sZ-dmPxI
Message-ID: <CAMRVtaaQVUjEc7Niuj+bR0wTgcwyqw6z=wjVOaA=FzprWoQt9g@mail.gmail.com>
Subject: [rtw89] Thank you! RTL8852BE suspend/resume fix
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-31988-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bparker8686@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: F3DC215B00B
X-Rspamd-Action: no action

Hey!  Just wanted to drop a quick note of appreciation for the work on
the rtw89 driver, specifically the RTL8852BE side. Been chasing a
WiFi-dies-after-suspend bug on an HP laptop running Ubuntu 24.04 with
kernel 6.17, and once I dug into the diagnosis it became clear how
much care went into the driver's structure.
Switching from s2idle to S3 via mem_sleep_default=deep sorted it out.
The driver handled the full resume cleanly once the sleep mode was
correct. Updated from firmware 0.29.29.5 to 0.29.29.15 along the way
and that smoothed out some rough edges too.

Also spotted the LDO restore-on-resume patch in the pipeline. That's
exactly the kind of thing that matters on real hardware. Good work all
around. Cheers.

