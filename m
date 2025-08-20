Return-Path: <linux-wireless+bounces-26469-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FACB2D4AA
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 09:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26D354E2199
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 07:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC5C2D375C;
	Wed, 20 Aug 2025 07:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxBZUq5s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A8C2D372A
	for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 07:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755674172; cv=none; b=poQ10NbNdxulYzJz2C8SXbgo4tnO9QIhBqICN4un+RhDDXsfeTcIsO+El0IlrckY8cEkp/bhqHzdokKMx5VdriKKrlp8peQ9tzJM+XB+zTZpIgLzKxllSMZZarnDA1fDMianq3uBjqBz80iIZf3zomqggbTIkf7upIJE4VMSwQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755674172; c=relaxed/simple;
	bh=Pvqkz74cwAWAKqDGTppM7rfBCsXyshd6IRokMHYnDGY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gclgT6tFg04eB8yLOA36B4reORFiq+x/YPsdk+Y9sfIFjs4S8+u0S35sA0EiJSWAR3+nfFfxV+NGb9YcjIA5fJi1adtMrkcXhgJr1kLrISZq/blVpnJvcm5yZFalcwG5iWHn3Z+hmvjtDx5Khbkr+qN31IHnvnOAZlXFntQYrPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxBZUq5s; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d60504db9so50665827b3.2
        for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 00:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755674169; x=1756278969; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M0dHzTUGhmzSN3DWQWYi7y2ZIHyg1zgtk80aOoWvnlY=;
        b=QxBZUq5sGXURJ1bB7Qnu8jaiajPXOn6ZULz1s4Vo3jRVK0AlkS2j3UL+jvcTP45sr+
         +KdMyjnD8wbIIfkoyF8wKriqooSUkPdWsyuOEeftqW8X+FU7pl7BA07qrsuzy7RwF4DE
         mJ9KU1LS91LlOs6eTYhi3d6NdtXwyjnk+9klngN27KV8hyq8AbvIJNfSDxfnzIUI89oO
         puCqTGnXlMOf0aecWqt2XzHajz2VEudP/1MoMK6IptTlqkfC79h9R7HMFq9dwQJF6AN5
         Yvt4HJZ3Q1vUl/2KaxgbTm18VWvDMZ/vI49j+qaJmdyvloGp6VwjxE/zti55WLgp4sku
         Nj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755674169; x=1756278969;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M0dHzTUGhmzSN3DWQWYi7y2ZIHyg1zgtk80aOoWvnlY=;
        b=rq4Pxp4KrW9Ea6XeiUo8pDqSw5BSleALBP/FEeI25S597nFUuukGneE+DtFAPmMJOQ
         Bna32HSPebo4+wEXQZxpZnIQm/MrKS/C1CYzSIhRGAsDp7mmba/dvYSjRBmGh/RJMNQY
         dRBNM2+ghRDwgka531nneFuCoFwaiF7Wu2m3OT9hXh00u8IvyLeHcUrBn/t7Om1yqSnU
         H+Zq/3d4gB8L829j10lCennajax3ZeCWG9IxDyU6J/Jv6ckVVPOVSSGNjhSud0VmbLSR
         2061oui4tLRFbCZfwbIS6LHV2qqP10Xtqg43aVSL1egvzUyernBaw62NtY7oVprmL70N
         bglg==
X-Gm-Message-State: AOJu0Yy3ZstlJF1ZUiG5gHdTeFMSr5fGYDkiXgdib98XmiRTK81yS4dD
	dtZ318QuzUFkLuQhPa5xcGtUQqZ/kYYmIJuFRo1Ld/alb8l+r1VhtB4mW1cBa7uc3BOCNvOGp3u
	R3h/GXLu7Jqv/HMMI7yjyhJ6kYevc8GLIWkml
X-Gm-Gg: ASbGncsrcpH3yiwREs8354Cy2bPDPwsNNLBLcP1kcrPHo3KbP5xXMR2Kq2DZHA8ftZc
	RzeI141rpPdLBIGWwoBzdQAMLijqMdmjj4Uye1L1FCyakPgBKL88bjDPbodipcF4DJi0zckN8dz
	yfLeuzqmVhlEmaZJlvB0vPxedccGkzCxDdmYb+DCXDO/LUtGXxmMA4KMSeHIQNoIVGcQWzMpT3d
	FuQu1rgcSHRg7+EKA==
X-Google-Smtp-Source: AGHT+IFH6ou42T9Jpv+Z7NsUTyDlplcdXnkt52KU3iS4FxWlJ/WRvvhx5WnFhI9otgK8KeBQQmgUKZxlA8HWsOOH0pU=
X-Received: by 2002:a05:690c:708d:b0:71e:6f13:976 with SMTP id
 00721157ae682-71fb30c9772mr19227967b3.6.1755674169430; Wed, 20 Aug 2025
 00:16:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: XiaoYan Li <lxy.lixiaoyan@gmail.com>
Date: Wed, 20 Aug 2025 15:15:57 +0800
X-Gm-Features: Ac12FXwHoIVMjM3L2-8R-orwQ4Y1luOmrjakthVW7uDq-L2osEXWRzq_M9zZ8KI
Message-ID: <CAH3TfsRyY1Rr9_y-v3ZcJvUzBt0y10x5i3nV43U0h6dkmUp5yA@mail.gmail.com>
Subject: [Bug] mt7925e: cannot resume from suspend
To: linux-wireless@vger.kernel.org
Cc: "nbd@nbd.name" <nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"

* Originally reported at https://bugzilla.kernel.org/show_bug.cgi?id=220395

Hi,

I recently upgraded my laptop's network card to MT7925 and discovered
an issue with the new network card when system suspending
(s2idle/s0ix). I can no longer resume my laptop from suspend; the
screen remains dark. After forcefully rebooting, I can see that the
dmesg of the previous boot ends with those two lines.

  kernel: PM: suspend entry (s2idle)
  kernel: Filesystems sync: 0.010 seconds

After running `sudo rmmod mt7925e`, the problem disappeared. I'm not
sure if it's a regression.

Detailed informations:

  Distro: Fedora 42 (Silverblue)
  Kernel: 6.15.8-200.fc42.x86_64 (Firmware: 20250708)
  Device: Yoga ASP9 (Laptop)
  Processor: AMD Ryzen AI 9 365
  Network Card: MT7925

Please let me know if any further information is needed.

Thanks,
Xiaoyan Li

