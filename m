Return-Path: <linux-wireless+bounces-3216-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCE584B36D
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 12:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AE541C242DB
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 11:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C8312EBDB;
	Tue,  6 Feb 2024 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0fGj7FL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2652412EBD6
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218720; cv=none; b=LwwcA0WDXKfJ4COs6EmAjAifpdtTFlgHkltLSe5hCUnAQ5PD6BeKLeWFTAysrFIUbt/HdylNEVio3bvLRvDQX8PotfiVdk5dBOvvdMokiFGAgJwT7mFE0APbqv5w1DByiaRvlouJb5QvxMeRvYy/5wyaYIRgyzwAJiMyHgWH0/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218720; c=relaxed/simple;
	bh=0H3TQgcZdMBPZzlqjT3wZEG3aVWblR5qVmqL07uw5Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UC+m1/ASIB1ReG+cIRZ3qi37cTTKTxjWcv3Ep5lXJqqMISSX0ZFMuT02pQkKJWpZunIwzoV+UxkrMrDySwewmt/19txtflnKVggVcHIYu2jhX17TF+sncOC1KVo7brA+SCwuHGnnnpEhuw3QgtRg1E0uGhndfYs8JAi/00WMF4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0fGj7FL; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33b1d7f736bso3094363f8f.3
        for <linux-wireless@vger.kernel.org>; Tue, 06 Feb 2024 03:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707218716; x=1707823516; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XPnBkGvCsCJC8yqoqhPyYvVOlSawmi40m3VKxw8PS3s=;
        b=L0fGj7FLmuDogNJqIfiUGOA6wzOkV2Gk/iz00JQ6ghZPIrW+7dMo49RhNMVii3jQW4
         aOfzMPnirCVYOXoLzr11JcLQi4Vscb95Hdx3lTLSNrLSgHBL5b4WtC+SUQzK/IZ89Wsj
         zZOWiaPIYb7fvGxpOklL17JM1ymSXEGZeN/Zux/qhRKuqLqKn+YIW5Z2YlmlhufP3t5O
         X4Lus5raZm+i+BJeq0WKmy0coBFn6qkdWsnQNpwH0VNgbVjfkfMIkSKyL04zRsbjhoil
         HVNoBO/THmYpg8cp1xe29j86sVSrAnde9Aby2VF9i65OLgfgE3jx+7PoaWUJgNRk4Laf
         Vfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707218716; x=1707823516;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XPnBkGvCsCJC8yqoqhPyYvVOlSawmi40m3VKxw8PS3s=;
        b=HSEDdp+l9b3giXBv+qmy8oCZGBY2WHty4iWgIFMM37XSNl+bNOQralYwI4mBZT1qpV
         dJkdBfT9+QqYolRAb96yc8TZRHCU1LAgUJFEqC9NaJR+mMJugXOB0uICOYa4biZbcN/w
         2tm6edMub5OxDj0XdCTGX4rqYw9PZFeKW4igkz5dD5rm1MPQ655fhft2AitY5DNPuMXB
         Yvr2vkYqMd55LMz2+i1/YqB3OP87RAfIGomzaJ6Y+IjpMs8f9y/rWMKsKIESoe32P2u0
         9OgLBm3ONmBUxn/daQ1gSH87xUNDOn8bsjAIOt/s7SekLsB1QGOjRMc43ThIFji4I3Ls
         rgJg==
X-Gm-Message-State: AOJu0YzjyMCMM7N9wXbtfFOHN5y3Mm7Rz2aO3SIfbPhekfHSsVB59BiC
	C8tNoUd+ukSpHZ4gqcq8l8QgbgM/7ptYdrvgYRN7JGZaQ6v8Ge9M
X-Google-Smtp-Source: AGHT+IGIFjcwhNK5IblvTvhlzCTLbtEy3VCyCK2uI5SipzG1fkpQbBLRGs0IdtntYkQbIOYswvKB6Q==
X-Received: by 2002:adf:ee43:0:b0:33a:fcb1:e1d with SMTP id w3-20020adfee43000000b0033afcb10e1dmr1116697wro.25.1707218715885;
        Tue, 06 Feb 2024 03:25:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV3iBCiBxuY9HCjBAVr0zhlnul6kvz7xRhh0zHD11YYVHlPMejYkCoE+oiMiIwDTxqV1HWdAv/mE1m4uhf/P875dNZbntZWZKY+PBVe9WyxyKHAHVi7VxQBNJEvnwk5stdSweocqhg=
Received: from nz.home (host86-152-202-149.range86-152.btcentralplus.com. [86.152.202.149])
        by smtp.gmail.com with ESMTPSA id l12-20020a5d4bcc000000b0033905a60689sm1875015wrt.45.2024.02.06.03.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 03:25:15 -0800 (PST)
Received: by nz.home (Postfix, from userid 1000)
	id D4DBA15F143E09; Tue,  6 Feb 2024 11:25:14 +0000 (GMT)
Date: Tue, 6 Feb 2024 11:25:14 +0000
From: Sergei Trofimovich <slyich@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org, Chen-Yu Tsai <wens@kernel.org>,
	Seth Forshee <sforshee@kernel.org>
Subject: wireless-regdb key change broke crda tests after 37dcea0e6e5
Message-ID: <ZcIXGjzrZrXPCBcp@nz.home>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi `crda` and `wireless-regdb` maintainers!

`nixpkgs` attempted to update to latest `wireless-regdb-2024.01.23` from
`2024.01.23` and got `crda` verification failures at
https://github.com/NixOS/nixpkgs/pull/286012:

    crda> make verify
    crda>   CHK  ...-wireless-regdb-2024.01.23/lib/crda/regulatory.bin
    crda> Database signature verification failed.
    crda> Invalid or empty regulatory file, note: a binary regulatory file should be used.
    crda> make: *** [Makefile:161: verify] Error 234

Bisect says the suspect is key change at done by https://git.kernel.org/pub/scm/linux/kernel/git/wens/wireless-regdb.git/commit/?id=37dcea0e6e5effb4228fe385e906edba3cbee389

"wireless-regdb: Update keys and maintainer information".

Both `git` `master` version of `crda` and `wireless-regdb` still fail
`crda`'s `make verify`.

Should `crda` key the key update as well?

Thanks!

-- 

  Sergei

