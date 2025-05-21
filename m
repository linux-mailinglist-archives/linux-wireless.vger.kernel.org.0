Return-Path: <linux-wireless+bounces-23227-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB966ABF729
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 16:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7D1178953
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 14:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A8918EFD1;
	Wed, 21 May 2025 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRp1YWSS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD291917F9;
	Wed, 21 May 2025 14:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747836423; cv=none; b=goXZM+HZPknQ5uFznqOKkIWuTE29D5/Yfl2KXW2WRsK+fyHOGb1PqUnaALx06BHlM/EgR7xTcauSFOrbk+/qLLHyJbVhR59+++dQUHAA2MIipGgRcJUeU4Dhght/L4aifz/RoQH2LmbsaXeE4EMEmIxn8gZJtecDextL/Zrd/l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747836423; c=relaxed/simple;
	bh=PrdPwrTaCyVZJ6LhMx3co+GcbOb13kfr2nu9W6OuDZM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ht3emG9Q2dGbP+x7ktgE58ZDZfwVrd1bPxi+com6/0dn5T7R6oyTf56mPdePSB1dZWAE+7AUJD0MdPz7dXLce+UIiR1Putll5kcQhAfYpFsUGH7bUzU6xAsrC1znwIMCa0tOETZDto3bWcvSvhTe2af2wjXSbrJeI4m3BM5PTdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRp1YWSS; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a376ba6f08so1792239f8f.1;
        Wed, 21 May 2025 07:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747836420; x=1748441220; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PrdPwrTaCyVZJ6LhMx3co+GcbOb13kfr2nu9W6OuDZM=;
        b=nRp1YWSSkjg4jDEDMNkgHlCwS181eUwqj9lFpLtn04ZAY43ggzs8D8Dd7/IgDJqYE2
         5yrtHlUJtYIJXcZe5mrjbzgzyE8HuukjJpHRWzhOzl7eus2xoM9GWSJIb/x42vHxvdFe
         5ziUJAOvxnxeQoOfOxewgcxGJgwVSqq9q1/ncY7Pk1YG3Ea2W5zQoSf9redOg4XkZ8/+
         9Wza35U7J13XongDDdo4Zaf+4mRX5agTOL4ItoH4tykEkg9voCg0F836Bmh808bIpbFI
         OQES569ag+yRdGpF5ZOdQjiM2DKaTviCL5NcmFnUFQnLQvFilsEE7tPRi/Kth1tOVpxw
         2yRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747836420; x=1748441220;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PrdPwrTaCyVZJ6LhMx3co+GcbOb13kfr2nu9W6OuDZM=;
        b=Dflo427qvgepvJ8yrsbFTsg1S3Od0Of9LFpFFhh2qgj/Be1QhSRkW/TE6bs19rkTVO
         n+2OltN98VckgfaPhon0m/e3Ma2VZBBO/I7qNxXy4jGcdqqu/mVVmn+B+1M4vhlDmi0t
         uJIvBLM6jRNhTUZsE2Sg42X7dP8dyIZCNjkAqkgeWCSate3ChJfE8i8qihMb3EwT89Aj
         hdW657JmCrP5a+gtct9n71d2EF0yjyKNHdNpTJkR9gW4dAZLb6j4GDGddEE630s8EIgF
         fFFlmnr8PDkSv6KRcVDaqgPOgzm8FW5tVkIOo3Lsh2ZaSyivYbwyQOQbimh9Duw+HO7+
         SpRw==
X-Forwarded-Encrypted: i=1; AJvYcCUiwrf321Riz+Za2/BrVhH7aQxqgDwP6ey/MOsc2e5sdAxZ6vuCiMGItO2O3+GmlntN4QPhi0MrsyxhIhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3B5+2KonyUoWAvsWESQGkswybEXYEhDLqgJ4tCol45BGoi/Mk
	srsZmud7pfK2nzTz3azre3cldFcNpD64BIRsIAVsvB/aAWFIscoUNc/q+rPAN3RlxeR7Pg1vz2k
	EWxIVnPIaAn4yvA5N1HHTVjpZa5sT5YAjcw9itw==
X-Gm-Gg: ASbGnctuOWpRYEvacQcKbWvJVbFPINSF8zmDAvuOOaQ/rK+DcOycJp0NQFl5ZuoZLap
	mHPflUn6ZciL90coglP+SehBOPOmckYZL+O0pPiZiex7vcajRyz2sEc6IslHGC/0hpbHT7/MVif
	dKy3gkDFoCJrCcEeTlZ7x9uLPflwkmXl9OGIqn/F8tBh/J+xENBeO/Vg==
X-Google-Smtp-Source: AGHT+IGWlj44DyZkDHN2p0d1xh93yb6V5ZaLQlfiMVxPwmzJHtxveqB5gjDhKF+gkEh0V5Z9d7d6NdyN03te1+8qmX4=
X-Received: by 2002:a2e:a553:0:b0:326:e80a:46c6 with SMTP id
 38308e7fff4ca-328077b3495mr80523321fa.34.1747836408759; Wed, 21 May 2025
 07:06:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: John <john.cs.hey@gmail.com>
Date: Wed, 21 May 2025 22:06:35 +0800
X-Gm-Features: AX0GCFt1Kr1QhJULNOmld5jR13TDzBLZ3oxzE20BweSiEtr1U6s_Oz1QcZvRmtk
Message-ID: <CAP=Rh=M50sHJqAUYfqBsOR1iTRaoykZy-C1wHsM2gQmE0i-__Q@mail.gmail.com>
Subject: [Bug] "WARNING in __ieee80211_beacon_update_cntdwn" in Linux kernel v6.14
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux Kernel Maintainers,

I hope this message finds you well.

I am writing to report a potential vulnerability I encountered during
testing of the Linux Kernel version v6.14.

Git Commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557 (tag: v6.14)

Bug Location: 0010:__ieee80211_beacon_update_cntdwn.isra.0.part.0+0x6/0x10
net/mac80211/tx.c:5040

Bug report: https://pastebin.com/8BAbTqUc

Complete log: https://pastebin.com/YgXnKSiP

Entire kernel config: https://pastebin.com/MRWGr3nv

Root Cause Analysis:
The kernel warning originates from __ieee80211_beacon_update_cntdwn()
in net/mac80211/tx.c, where the countdown field for Channel Switch
Announcement (CSA) elements in beacon frames is updated.
 The warning is triggered due to an invalid internal state, likely
caused by malformed netlink input.
The user-space process syz.0.238 sent a netlink message with an
invalid attribute length, and the simulated driver mac80211_hwsim
attempted to process it.
This resulted in invalid countdown offset handling, leading to a
WARN_ON() in beacon generation. This is indicative of missing sanity
checks on user-provided parameters in the beacon update logic of
mac80211.

At present, I have not yet obtained a minimal reproducer for this
issue. However, I am actively working on reproducing it, and I will
promptly share any additional findings or a working reproducer as soon
as it becomes available.

Thank you very much for your time and attention to this matter. I
truly appreciate the efforts of the Linux kernel community.

Best regards,
John

