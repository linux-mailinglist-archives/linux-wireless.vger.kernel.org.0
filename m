Return-Path: <linux-wireless+bounces-25798-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25352B0D269
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 09:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F41CA3AB019
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 07:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD1617C224;
	Tue, 22 Jul 2025 07:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="P+tptVjn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175B1228CA9
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 07:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753168634; cv=none; b=tpaQW1H27Sbiquv5rJYTKcanvbDH9KpxRHSrBVoum3LBclLeCrtuZ8yToHVml8vW7qNcSGUnQT4tQxVP6LamH+TUILnvVjnJt9fuyZSNwyn9vjc0R2MXieEXPXWgjo9jnW4DvJc34lXidX0YK/JDYODWWGXgkzER8opwfMUk0GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753168634; c=relaxed/simple;
	bh=I0yeMZyxHo/Qgxuhc4+KC48tuAbNCuFq0ZO2Vy+xj9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bqSHPmzMK9tySRtFVbRikt3iLkxV7sJUKdvLzA+j+IfFt5uyV0A2f+crQ0sND14pUrvMZSC3DTQPRzj1K/cNESxwGgQ7QdC3SWUriMtNQGM4+7eBH6vQIshCEDsFoz9AGYoj+PJhDJAZgHBpDGp04CgGgW4nAAfJ7IQ6c6JfOfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=P+tptVjn; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-315f6b20cf9so5410565a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 00:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1753168631; x=1753773431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=swDJdnCWNaTcuaeP0LN6/ga/YL9Rh2GchtCOGrqc8Ho=;
        b=P+tptVjnLsY5W2awZkFu86Afti1c9h0ENumK4HdJOrktATfManF9OnDwtALKL05Bk6
         7Y+a4KbpRhj1KjPmcISYivPI7A1u13N2DmsBTHbYdQfTvwJgLPP11HEDQ9MzT/3O6sY9
         R45dCNuGzKvGRjUGWqgIlENXbIKhpwTgQrpnIPP6rcY1W8LEKqf9DqysUPlPtjO5Ow0n
         dtWwImtMY8956m+qyeeDh9O0k2rrIO6sRlS05yb4QgdibUQ1u/LpMT+z7j5PR/Pkfcf7
         pJw8pcfDQiV1uM5CEgvltLzupxdXY1u48wSyHmx17ne7yj7WdxWjRM9nxHQUsU4gwXB2
         hD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753168631; x=1753773431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swDJdnCWNaTcuaeP0LN6/ga/YL9Rh2GchtCOGrqc8Ho=;
        b=VkO67YoHPSY7tNROP8xUyLw8QhTfpX3D8YrlDT5m3sup1RdYl9zN/b+v35EwWTfScd
         u/RYL1bzfM5uORkvBGLb2hOPG0ONxGwOjD4ljK4D5fBk8C1L49bgkw14X0pOI7yhyppg
         pooOJ+XfFSeG+BcqwDYJnD4jNJDxuwgPo+NKHaiUVOgyML9kEzdkAtnLWMGlw4v+QSu1
         l8w0lfwK5buM2jLrX79vHT4Ou9C8T0iL5Sx4AZCu/3JrtsNtj3N23ynvMryCybqCgyFG
         wA5qR7OHjSFuM7QXaG/Wp/c6wx5yaUIHppc3iEzXWVOqGmTaxB7bTGO7OjanDgcV1/se
         hnyQ==
X-Gm-Message-State: AOJu0Yxy06MyRJfLWUDXKh22Vp7bFAm5P+2UvPeDVBk37nUPvG5dnVzJ
	yvuivXkMZyEOH9NZc5ZzBIm/i9DXZKNo2hQFSvikglVMwW+Iv5iU5dEmxIiQ9WWAeHo=
X-Gm-Gg: ASbGncvkhjF0u/mzLp+bsZaUESMmkWC1GJiachhyljvkw9t8L5DFt+6FiQEp9aVXSrv
	y6QHL0XYiBVxMOC0z2dlzXaYhc4uc+vLEssKojvFbIJpghd02VhgJ1lHbKOr4U7GcEJV3h7V88s
	LX4oV8k1zHQNgy61DhYd/AxltBFtSoYjgo2RyJIRogoo5nz6vkBhYX5+fbrjCIU4O/O0dTCcauX
	iXqln20mm7RAr1YnfUiSPDDM9ap+qQL9HjAwnfVg2c8cIGVib08ldhs8BLiRZW0m3eGvDeDAydV
	+aL8dmIqM9WxSqTzhytYjdCCsX+Xl6Xoa9MNIqvLjNFssa4yaNALCXAvodilbbJwdSalLrtTcQA
	tXFto8JO+bnbq7sKu3Ur0xSUy6Lg/Vvy1c39pKleQzQETvBidJa6OquZc2hT821DTDXxRSMKsMU
	+Qxpo=
X-Google-Smtp-Source: AGHT+IHxowSMYT3RD7ELrtHz6dtzMc8uQNAW6rYoRwj+WaqzD/F5VGV3Vq0uJy1rpaHtO8HfjD9WCw==
X-Received: by 2002:a17:90b:3e47:b0:315:cbe0:13b3 with SMTP id 98e67ed59e1d1-31c9f399399mr30035084a91.7.1753168631082;
        Tue, 22 Jul 2025 00:17:11 -0700 (PDT)
Received: from localhost.localdomain (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1fa8f1sm11099772a91.22.2025.07.22.00.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 00:17:10 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [wireless-next 0/2] wifi: support S1G TIM encoding
Date: Tue, 22 Jul 2025 17:16:38 +1000
Message-ID: <20250722071642.875875-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An S1G PPDU formats the TIM differently compared to non-S1G PPDU's,
meaning in order for an S1G STA and AP to correctly coordinate
power save, the TIM PVB shall be encoded as per IEEE80211-2024
9.4.2.5.1 Figure 9-213.

An S1G PPDU uses the notion of "pages" where each page can represent
2048 AIDs, for a maximum theoretical limit of 8192 AIDs. However as
there is no page slicing support, we will be limiting the PVB to
a single page describing entire range of AIDs within the bitmap.
This is permitted as per IEEE80211-2024 9.4.2.5.1:

"If the Page Slice Number subfield is 31, then the entire page indicated
by the Page Index subfield value is encoded in the Partial Virtual Bitmap
field of the TIM elements with the same page index."

When this configuration is used, the PVB is broken down into a list of
encoded blocks. Each encoded block has a maximum length of 10 bytes and
can describe 64 AIDs. We currently only support block bitmap encoding.
Each encoded block contains a block control byte, which contains the
block offset. The block offset represents the block index the current
encoded block describes. Following the block control is the block
bitmap and between 0 and 8 subblocks. Each subblock is 1 byte and can
describe at most 8 AIDs, where the respective bit set in the block bitmap
indicates the presence of the subblock.

However, there are some further limitations. Firstly, the TIM element
has a maximum length of 255 bytes - and given that each encoded block
has a maximum length of 10 bytes, 32 * 10 = 320 this exceeds the maximum
TIM element length. As a comprimise until page slicing is implemented,
we set a maximum block count of 25 (25 * 10 + 1 + 1 + 1) meaning we can
describe 25 * 64 = 1600 AIDs. This fits within the existing mac80211 bitmap
and is more than enough for current implementations. In the future, when
page slicing support is added this will need to be modified.

Parsing support for the S1G PPDU PVB format is added on the STA side to
allow full power save support for S1G drivers.

Notes:

(1) I've run hwsim tests and (obviously) tested the S1G power save path,
    but the 2 hwsim power save tests only check multicast traffic and
    even then only 1 sta. So would be good for someone to confirm that this
    hasn't broken non-S1G tim encoding. Even though it's only code being
    shuffled around, that wouldn't be ideal :)

Trace Example:

Tag: Traffic Indication Map (TIM): DTIM 2 of 10 bitmap
    Tag Number: Traffic Indication Map (TIM) (5)
    Tag length: 6
    DTIM count: 2
    DTIM period: 10
    Bitmap Control: 0x3e
        .... ...0 = Traffic Indication: 0x0
        ..11 111. = Page Slice Number: 31
        00.. .... = Page Index: 0
    Partial Virtual Bitmap
        Encoded Block 0
            Block Control Byte: 0x00
            Block Bitmap
                Block Bitmap: 0x01, Subblock 1 present
                Subblock 0
                    .... ..1. = STA AID13:  0x1
		    .... .1.. = STA AID13:  0x2

Lachlan Hodges (2):
  wifi: mac80211: support encoding S1G TIM PVB
  wifi: mac80211: support parsing S1G TIM PVB

 drivers/net/wireless/ath/carl9170/rx.c        |   2 +-
 drivers/net/wireless/intersil/p54/txrx.c      |   2 +-
 .../net/wireless/ralink/rt2x00/rt2x00dev.c    |   2 +-
 drivers/net/wireless/realtek/rtlwifi/ps.c     |   2 +-
 include/linux/ieee80211.h                     | 110 ++++++++++-
 net/mac80211/mesh_ps.c                        |   2 +-
 net/mac80211/mlme.c                           |  15 +-
 net/mac80211/tx.c                             | 173 ++++++++++++++----
 8 files changed, 257 insertions(+), 51 deletions(-)

-- 
2.43.0


