Return-Path: <linux-wireless+bounces-34650-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ez7xGfK82mm15wgAu9opvQ
	(envelope-from <linux-wireless+bounces-34650-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Apr 2026 23:28:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6E33E1BCD
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Apr 2026 23:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD54B301CCFB
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Apr 2026 21:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF8927A92E;
	Sat, 11 Apr 2026 21:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chHtJNjD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F29230BD9
	for <linux-wireless@vger.kernel.org>; Sat, 11 Apr 2026 21:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775942894; cv=pass; b=fGkBSbYisnxVBN6MNF2MuYdNk6OukV4EUMs3iHrD9voSBYWvcHW5kHVuLjlelJO7N3uGseJXTQpR/9gih+XJnsDX7fwa1JskYJRJJgEH0IF6dBoldRLxpEnUMDLYO+9gHJ92SoVMgH6g9N8Vu5YqCu+I/0FSTCugHLmMaN5gMeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775942894; c=relaxed/simple;
	bh=QRCrK53l8UwEWSyLWN/n8ALSgs4igj/WkQCyjF/qrKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJOjKT3b5R3YX5Lz5klS2C4znsHQMzDqyI3ZSsOJc8f3rL06GnPSLsB06jEXLW/llhnJU+Ugao5pDb3SRgAbUrhM3DOtrdeUiyYRsEwUK/s8sGXl08kUIT16agcyPDCDRbMjLnO0zCIp+MHZ1G9P3oy47MzCdkMrmuYr0G5Qpk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chHtJNjD; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2d832f2f44cso154058eec.0
        for <linux-wireless@vger.kernel.org>; Sat, 11 Apr 2026 14:28:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775942892; cv=none;
        d=google.com; s=arc-20240605;
        b=OJdM9vDCrPN2o+07ep9t0BDG+Qz9xsarCYYaWUEUdqPuxz8SqOSbYgC15EXiMZ4Ens
         r+7koANStv5cNUazuEs2NrgHWdW4jGgtmwrm57Us3o8atK2mfFJsbg63f0qApHWbvnvw
         YJoUAnV0N4pA0EH2dEaYi6QURaM4Es6iJCNVLvbNA9yW/u7q0eSFmZf8knTSDL/2tLVF
         mbBahQAHq571e/wwKUPztYh11iQn6SWHcV+bV3fYpe0p3LQFsPPRgZm4m/xb0AAVF5/K
         RKGdhEs8NXZdH/fQ7yxkMB+Isif3wiW2OZ/G1B7vhQjTQENCAnep1BVnkfuxXnWosEYJ
         9+kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QRCrK53l8UwEWSyLWN/n8ALSgs4igj/WkQCyjF/qrKg=;
        fh=BLj8Rl5RXUBbUgizCEJAxy1Rku6HTmEMnpmzV/BfT+I=;
        b=icVOF+odaHf6PNDxi3FAPI1+V7ZP4gt6TQ7HgA73csxTg2LWc9CxQZePSSYyx+ufEN
         1vULNALHwmhQvrtbF+mMm8uj5H40zLeGcbSt1ClVJl03k7PszQ7VWLaVJ/kurw8uCvnb
         9p6aiozNERUe+DCIQpKH18rzTZu+lQE/gUR2muFh8OngLNP5mTX+tr7h15BGxtwUoUya
         m5/IovmRfr9tIyoGqHfKQrHUzNOtUbxpS3nLc7RMJH7BCFEjNRvpN+xoQ4lxLtKQPVDq
         5H3LZbxh7oRrtXyWkjL7gF4elIoTKVtqgVLrwWzFISVwivGNkadV2nWOFNVXWzGek63Q
         sjCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775942892; x=1776547692; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QRCrK53l8UwEWSyLWN/n8ALSgs4igj/WkQCyjF/qrKg=;
        b=chHtJNjDyvsEEZhg/7flJBCIX8EIYANNhryB+H2cLPuTbiwMpTwRescLLMp8GNSHNg
         mtGxFpB1speFHT2Ti+dZ1Hnt5zoDkh3mRvuhWi6atywpjJBwi+3v4drmdeL5yIZByhnX
         EcSweFrFgBtT1nFuxrdNPJStTMLgNiWyNZFgq3S/B6CrfNAm96B1N2iqjfj9SepfAozh
         FB4zMmNn7SMvhuCbXkCtThi0EzzvIL1xt3Nc5peSQBLeYfhIcDr/UGj/JRkrZHx2THXo
         jz7zXfL56wL++0MP2fWnPlL4r1E44/iU4lALy3N2xFBKEZY6cluUN7FvLkn999A9lQt9
         WXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775942892; x=1776547692;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRCrK53l8UwEWSyLWN/n8ALSgs4igj/WkQCyjF/qrKg=;
        b=shYqEDZKRocN1fmhapAYZl9iCSgJcEesb/EytpPrbxYLedaX8OLSr5Sm/yOf0cNWdA
         FWTCXKRZE37RDt0Of5VAMxMrIC60JWtUUuYaTpmzzdGWERkmrUoHwCrgFzmdn18N2SGv
         MrU5QvZUWTCR9fIGN+UDu+XNfBNh5PE9E/xqwx2Q73kf4Z7GuP+2hlaqiPGH0IfAP8Qz
         VQbf6y1IiRN89ZaJ92GmsFXoV/StR8nsWM4rZE/jHKt+VF18nTW6H74lKmuv9Hrpo33J
         QdnJV5HvyJ1J+xcuQ3uy4Xzj5N4Hn0Mww33sy+qGkpHzVScpC8TkV9C4OQli8H7gbRxB
         9lPg==
X-Forwarded-Encrypted: i=1; AFNElJ/5q/+rNvzB0tOB8QxYi0fMcItJsXIKTtXMZFlpsDaYUxU1dnh+nZ5pa5wQinLmXYS3n4TQsFX+jYy8eExDAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YztnCuO+9tr6Uwvhaf9kICBax4SYx99TFBJCq/bMrIz9wggXRL4
	0ITEuQZGU2iPFmUBjIs7EvI0DW2sU1lH2uTc32nTyUaqnvWUM0M92RgyJHURQgCRt6hhxO4ILpj
	QRzLv1Nzzr8nfmqIMncaLtL/Ltg5ZQIQ=
X-Gm-Gg: AeBDieuLEOuHhf0bKyY3/o2onhiv97g5mOl7q3YImnGHVHjcWhp7h1BS66RgEAEnfch
	yvQnsU6jDyfIZBfXxIeSnheXUrRK9XydqqmPNA0ZxLy6vRha28IDr+/+uBiAKPJHfb5sl03DoyT
	yNbVFNYoN0y/WnKVD4tpyZ1QdNQpry6HC05/LtyO481AMio63sW0phH9Zpe4q2lLy1mvt61E+mS
	ZKp2it0qOdvknHP1rCXD/nr/5bJtAP1+aeAlse8+3ResKZ4tqbuFKPwkTyn5yqYCvS/enxwDt87
	zQwBXd3S
X-Received: by 2002:a05:7300:e207:b0:2d4:afb3:7af4 with SMTP id
 5a478bee46e88-2d587990c51mr4531084eec.10.1775942892437; Sat, 11 Apr 2026
 14:28:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303104217.180715-1-goodmartiandev@gmail.com> <20260315081221.2678478-1-goodmartiandev@gmail.com>
In-Reply-To: <20260315081221.2678478-1-goodmartiandev@gmail.com>
From: Sheroz Juraev <goodmartiandev@gmail.com>
Date: Sun, 12 Apr 2026 02:27:59 +0500
X-Gm-Features: AQROBzA8jYuUrNGsRBpoQAuIwELHw6dxtkiMbmYTNVFngUW0SiZDuEnRMISRBGY
Message-ID: <CADPJysxbXtB_nPpMt5_FZaqsEWP_e=3QjKk+j8R9NuTfJFvU2Q@mail.gmail.com>
Subject: Re: [PATCH wireless v2] wifi: iwlwifi: mld: stop TX during firmware restart
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34650-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goodmartiandev@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: AC6E33E1BCD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Gentle ping.

This v2 was posted on 2026-03-15 and hasn't received any review
feedback yet. I realized after sending that I dropped you from the
direct To: line in v2 (it only went to the list), so this ping is
mostly to make sure it didn't slip through the cracks.

Since we're currently in the 7.0-rc stabilization window, I wanted to
check whether this small bugfix could still be picked up for the
wireless tree, or if there's anything you'd like me to change.

Patchwork:
https://patchwork.kernel.org/project/linux-wireless/patch/20260315081221.2678478-1-goodmartiandev@gmail.com/

Thanks,
Sheroz

