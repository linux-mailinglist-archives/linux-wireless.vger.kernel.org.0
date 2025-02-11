Return-Path: <linux-wireless+bounces-18740-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12306A3034A
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 07:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759D4188A6A9
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 06:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDE226BDA0;
	Tue, 11 Feb 2025 06:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jT+Guqp0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E7B26BD8B
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 06:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739254547; cv=none; b=MBX5l+4EF/fcaYYqkq8S8eEOH4A/SbfuZCVd8cbOgldjaarTbTxnBhjTV1KPMzljPrczIuxfeRjmRoYB/PB7AyLAntzRN5hcwv4JHQUadf+tm+NK5toTAv6JOTC2pw7fgh8E+4p634kwxx5tGBB+k/N+E8i8bsVw2n9YLLgGNhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739254547; c=relaxed/simple;
	bh=wsRT9LZH7XrpLa27bB/Wes0PWTQLYxBIt7C7Wd/85a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EtvfXcbM7rS+VBuUY/Gnt18lTXOFU7YOrYDs9Lv4qJEG2gPSZ+F3XFpslsZshddWOaDjELQx1736VvZw/S1LaqRxJ5FbveP+5E7lP+PIpDDZyYkb9K7tTpGTT0midyIiVM/zgQH4eYl/wt6Jbidf1y+riNRKaXczVowxL3Dkvvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jT+Guqp0; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21c2f1b610dso125890815ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 22:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739254545; x=1739859345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsRT9LZH7XrpLa27bB/Wes0PWTQLYxBIt7C7Wd/85a8=;
        b=jT+Guqp0BmxCW/CLFeEfbaRmR00M5dG7yQrYoN2pf/QQvLqj9IH7g6luocj3vpd3Cz
         x1baXiJuWs3wddbhgtX+IBuoy1z87XF+jP5TdbZiSj3s5iZUK1h45BCvP+0FxAKs3kFp
         I+JMJL5wEIbhcBpDGrLS+Suzc6uR/hJaVqcu4zSmBBMBF6Ru25rOC5+t/hQycM/+VKuh
         d9qU2CHHc3805XjuTAMqzfGolmlW36pt8eJD32VmkEpz/ZS4U8NInoAmu++Bmueso1MI
         NZ7OoUQ763u86QpAEa8zi92SBXVZnjM78tQ/fY5+3Xz0qeN42gq6bW3F2RUD8vDrzKe4
         C4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739254545; x=1739859345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsRT9LZH7XrpLa27bB/Wes0PWTQLYxBIt7C7Wd/85a8=;
        b=imUC7oeHP5OEwkTw4t0wmlMDCUU5N9G/5spFjCf6lZRVV1d+up/Yom+wkmmxSRBLue
         +hsg9soRQWE+oddPYhDjTHot3G4YIGwmPQ5vdoMcaOBETq6YNqTKGH8jWjSPmnw/2rCG
         W0yCqzFblkjUTqJwuGOnoAq8I1r3SyTmZGqHyIdwmRDt/qoodkr9QX5hKmU1IR5F6BlY
         VQhhPxoF4bbcBM/funUozE2Fgz5/zHVvzbHFWAooFPD0wRrc4/tBbsJFfVdZ/ZMy9nza
         soKnTbmD9m72NYEjREruTdB2r+z/+y4+vFS0oDUHFC30htaIvPt5bmu01lLl7ktrZ/fC
         IrOA==
X-Gm-Message-State: AOJu0YydiyhaYDLRQe+clIjy9jttc+7AG5GqXtEdb05xh1Aqo9RQ1xJj
	iTY3m0KA5NNxEi83hLIrpi1tjPOU9d2CDoJJvJ+hwNcaRmB/XtBI
X-Gm-Gg: ASbGncsxqm9j8QSaVPsGP1bA/urif9Ux/odkB/GjtwDmSXvpwzGGRVR/Mn34J/xu+Rb
	RI0Kt9uhCLpgGX7O32/9NCXEzBuSnzSBTNRZzzh4TfUel4Fc9wZxU/4qLa2VuHIpSLTRWB2KKQ9
	F4uo08/k53tUV+uGjkygNkg87nGOfCrBuQPTIcxMaZapBr1PC72pGcUIuMNRAb5Wg7g5TkwX57h
	h19f5j5jxuCc3RUz2daGpNG9+veJZ/kZtl30xrOdSp6duV1uyUyzeKpLJQhUt6K9+qWO1qVsU4O
	87XOuIAQdSsP/sGAzaR1lsbHgjGfcVjnupuynk0xyEu5q1BsSZlNX2Iza52GTsWGcw==
X-Google-Smtp-Source: AGHT+IGDa27EJyFMm9C+IUFsEwdWc+sxcf1zqPdCPuf9sAulOY9E35Ce28YYY+CebNShtw1WdErnmA==
X-Received: by 2002:a17:902:da89:b0:21f:7082:1137 with SMTP id d9443c01a7336-21f7082121cmr192004035ad.22.1739254545437;
        Mon, 10 Feb 2025 22:15:45 -0800 (PST)
Received: from localhost.localdomain (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-21f368b27f9sm88685685ad.228.2025.02.10.22.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 22:15:45 -0800 (PST)
From: Zenm Chen <zenmchen@gmail.com>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	rtl8821cerfe2@gmail.com,
	zenmchen@gmail.com
Subject: RE: [PATCH] wifi: rtw88: Add support for Mercusys MA30N and D-Link DWA-T185 rev. A1
Date: Tue, 11 Feb 2025 14:15:41 +0800
Message-ID: <20250211061541.1730-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <1f46070899bf4ddaa7b668a1f96b85ed@realtek.com>
References: <1f46070899bf4ddaa7b668a1f96b85ed@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> By the way, these IDs aren't in increasing order, how did you pick IDs
> from vendor driver?

Mikhail Novosyolov taught me a good command [1] to find out the missing
USB IDs. :)

$ diff -u --color \
<(modinfo a.ko | grep ^alias | sort -u) \
<(modinfo b.ko | grep ^alias | sort -u)

[1] https://github.com/morrownr/88x2bu-20210702/issues/224#issuecomment-2404823387

> Not sure if it's worth to sort these IDs so that it would be easier to
> align IDs with vendor driver (it should be sorted as well).

okay, I will send another patch to sort them after this is merged.

