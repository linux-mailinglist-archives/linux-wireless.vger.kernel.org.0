Return-Path: <linux-wireless+bounces-11584-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41F2955B97
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Aug 2024 08:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D9FB281E28
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Aug 2024 06:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B0CFC02;
	Sun, 18 Aug 2024 06:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWIkVKkf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85A211CAF;
	Sun, 18 Aug 2024 06:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723963740; cv=none; b=N1TX9sa2qVQeJlEM8ygUjukzJzz+r38VJUITTnz9exbykgPU6/PdM0cpK///AKVAv72wsC4mDu+wnyBuvoVKtG8UYeiYTr7yV2pbMLawp24EHx2R87sYzeOo09qT0ipotC+U+ii2NmAoTBjUEVScqBQdWtrOZnocLqqVLogKUyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723963740; c=relaxed/simple;
	bh=TpetKscK5cqGDSQEITixAF99ndmI0U0grrVZBslHV/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X7uSYyzPeTgWP1AceP+UmRZLU1XiECQwFcnVm7QTVoOxLwdmwaIpNY2WkabkBbCojw11TYnmeBZSNvYMGrbQ1FPspReZQuCKj5DcMnFaBGo58JAlr58d3fhLBh5kOdVTKi1yCUOGez2F2Xf9eaU//riYP5jcezBhOV9y/Wbc/RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWIkVKkf; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4f6d01961a7so1092739e0c.2;
        Sat, 17 Aug 2024 23:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723963737; x=1724568537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sydfE0Orj3x7Bv6zu0yP70uPC0xmzYws8gdLFa2riUY=;
        b=LWIkVKkfJB3ToDwwXAA1jF0PT7FtUfB2xPCEKRc0PbSHGHQByMkYBUJyRjrzpNIdMw
         XXIN+tOVRy7ZoNWMGhAUMB7dlTd/vaybaW3Z1YkPfTaBh8FmcCVuLHyY60PSEAXoQ119
         hTQwn9357TPt8++cGprajNVyM8Yum8hk0w4NZZJ+llqng8fP7DonSQbxu7pMQnfX1FJq
         NBtZ6AnG2KhNfZzUZ+rg4bcPDklzlQiE81IIVdpA66tlVrPuqYgUdBqyva3MUuCR92Fj
         UWM0GABt2dlYbgQ7zbSr8hJsmRcN6dX73Fdo025DqQS3iv9mT+QPAemZR5AeeGUf6xvP
         YmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723963737; x=1724568537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sydfE0Orj3x7Bv6zu0yP70uPC0xmzYws8gdLFa2riUY=;
        b=AYHLUH6X0OKKotRTEP7lyDuIsl6GnOACkSYHlxqbOmXXDPsjYw6Nw5W/10ECwBy94n
         3mBw2ZRPWvFqFWkEarCABKuvuQ7mHX/4K5/bZyWW9fB142zMXFjAAKSp+eXGf/jkmiwG
         JemvcOhANbsoMXbievgWDfThHS+iBpSs5+CFC9z0yvLYeCTDS9H/jJ3HGn8u3Y7vw9GA
         qZHRkaAKe51RgVkTRaeqNjo0yxcgdj2PPCYqfpoeprcHCh1eMv5a7D8iAnf/yPcnOLU1
         X3GZjrXRHNqGVG0VBnvJqbj7mkt0USZwU8caZZ8cxQEtfS8CflK164iC0WvDm8ERH/ef
         CHmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPbbipwg7YCZ5VrdJvo9igrk5EtEaURwlk5R+093/TVrvpUkKrlOcNaLKUiAm3+y4RJBorXZ3IHqizZd23mLsmkLWoOataJNYtMtDG
X-Gm-Message-State: AOJu0Yz488dncMjeC8+y4h7smQil3xsJs2kmtfelFfVBuppfB75k1R0L
	J/TW6MwayGjrfi0RXsN/+5yvV/0jYA7+bjllAQDJv8ByC3xtfmFNpM0CoSQg
X-Google-Smtp-Source: AGHT+IGBK/coMUhfoc0faG/kBm6UFWHI1I8RjmndG9JKV38W+cjJkvOwpU6s4FpgTBy6YJ8QJhU9Og==
X-Received: by 2002:a05:6122:3d0d:b0:4f2:ea44:fd36 with SMTP id 71dfb90a1353d-4fc848c20efmr5448700e0c.0.1723963737520;
        Sat, 17 Aug 2024 23:48:57 -0700 (PDT)
Received: from fedora.. ([2800:e6:4001:fca7:b7e8:4418:a953:72f2])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4fc5b8e30cfsm811032e0c.18.2024.08.17.23.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 23:48:57 -0700 (PDT)
From: =?UTF-8?q?Juan=20Jos=C3=A9=20Arboleda?= <soyjuanarbol@gmail.com>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: miriam.rachel.korenblit@intel.com,
	kvalo@kernel.org,
	=?UTF-8?q?Juan=20Jos=C3=A9=20Arboleda?= <soyjuanarbol@gmail.com>
Subject: [PATCH 0/3] Cleanup: Formatting iwlwifi driver
Date: Sun, 18 Aug 2024 01:48:56 -0500
Message-ID: <cover.1723963126.git.soyjuanarbol@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Code Style Enhancements:

* Pointer Declarations: Improved spacing consistency.

Macro Improvements:

* Enclosed multi-statement macro in a do-while loop.

Formatting Standardization:

* Replaced spaces with tabs in iwl_mvm_vendor_events_idx.

Juan José Arboleda (3):
  iwlwifi: mvm: Improve code style in pointer declarations
  iwlwifi: mvm: Enclose multi-statement macro in a do while
  iwlwifi: mvm: Replace spaces for tabs in iwl_mvm_vendor_events_idx

 drivers/net/wireless/intel/iwlwifi/mvm/power.c      |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c       | 11 +++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/vendor-cmd.c |  6 +++---
 3 files changed, 12 insertions(+), 9 deletions(-)

-- 
2.46.0


