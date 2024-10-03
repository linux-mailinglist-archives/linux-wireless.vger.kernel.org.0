Return-Path: <linux-wireless+bounces-13470-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD49198EFB8
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 14:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7643528353E
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 12:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D177199249;
	Thu,  3 Oct 2024 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxDdbLMA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9D519884A
	for <linux-wireless@vger.kernel.org>; Thu,  3 Oct 2024 12:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727959945; cv=none; b=LWBvKgSXjIGaroLFcSLoa1Zmn4GOxV47BkmXv/uyJ9oP7hu8qjldvCARSdzG8WSVtDpF1bYjG4kU0fillhYRPfeohflalk7UEDfoSe2jDsc/U3qYX79s4E25SOhOFC2oMt/2klkM2qzsD7bIOAIHBfsThVoGFxs9KOvSmXizxh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727959945; c=relaxed/simple;
	bh=Vrw4QPwPblG33Z/u5irQ4GUjUBy24B/uprQUP41VtoQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=K6bWZzjDO3R4mHNqv+WLi7GXi6Se2Uanb7Nq/sQJj3R5MbJ/wb+P/OAvwe7F1u1CMaNNX/mV/vzvi0vxz3gou5bUVLnzY/UgivuKZDsoU1ravpdKouCi+Dm3l4fpzLMjoil0g0HRm50kY+hw7hI4qSFTX+qYqk8G3x2DpqYbI2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxDdbLMA; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6db836c6bd7so8698247b3.3
        for <linux-wireless@vger.kernel.org>; Thu, 03 Oct 2024 05:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727959943; x=1728564743; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vrw4QPwPblG33Z/u5irQ4GUjUBy24B/uprQUP41VtoQ=;
        b=mxDdbLMAxlrFStzziYCef7MYmYBWGOegkEzl21BC6XqKLsR4sWrvwBFqTSHD8k9tYG
         cSUeGSCOSPUIKzHXMP/qizIrwwvQQ0E8K1O0yFrVYr5pggO2YwvIWryHrM/cP+3OStKj
         klzeWgSmARN+DXDvn1fFT0rF1p4v7NS7mbjkb69bhPm8KopfYQjBa0gHxAXFXXZ7g41n
         RBx7hAzwP6CO571Hi3yVZBb65VbD90qYdDIof5wBiwkP/ekPjRYzgL0wHdvYn8O5spmb
         noZIEOVOyBBFYBN6FQvUJf5iDkVsCWU9lP8jdPc7yeZwu2ZfzHqEiyaK740GfAuaftAI
         5BEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727959943; x=1728564743;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vrw4QPwPblG33Z/u5irQ4GUjUBy24B/uprQUP41VtoQ=;
        b=Xub9jr19Ssys7Fl2JJtbdEoRxfn8rbrxDBSYnQqF5FFMJ+YqSIEV0znkhnwA1DYw0F
         5hONn5PYVpmcHKCCk2+Z5sXljnEOzXr+ZTYFlAv8VvVwxD8mezeFIKfJy/4Bf0+3Mj+d
         JoN4+RT3gu5u30na8hfgoNT8gLoV+cZtFnWPaOWRZdPX+NoPYQRsv1i/3RrS5zPXv9Q7
         CIySlYTyIup/BunI+V35iiifhuIACXux+gg576TyE6gp0+VLE3ZiwTZs0xfuLzHfN0EE
         QoJGRqUvB2kKNEjkTQO/CUgve8cWu/iv3RDIR8c/AV3zbqbJHAfF2pcFCILDXvk4ZlLt
         LZYg==
X-Gm-Message-State: AOJu0YwrexfBY6Lu0OwGeHXakiMQNX3hzKvE0l1F35z2yIdP8QT3h5FP
	Mjbeu5Wi9V6yZ8PvmYeBw/h5KRY7f1VBQCUsn4lFlnmItkuSGeYbFfiOex7G+TVbfDbgqxnPtJK
	EWS3CW6ImOE12Cd13IVU/sT7NSIirpBJyCU4=
X-Google-Smtp-Source: AGHT+IHJx9zqXtXJTTchCX3glOffk9Oa0Tj+s3Heu6w8+N8FBzx0eK9WAVpHqwNpR9hEqto4Y/jP7gydBnWVQsbrAsA=
X-Received: by 2002:a05:690c:660f:b0:6dc:56d0:acbd with SMTP id
 00721157ae682-6e2a2ba81fcmr74887557b3.12.1727959942636; Thu, 03 Oct 2024
 05:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sanjay Bhattacharya <sanjbh@gmail.com>
Date: Thu, 3 Oct 2024 18:22:12 +0530
Message-ID: <CAJqS-psO8ykm70VBvi_T05PhOYb4Xvs6MeEUzc2a5uq-EUhM0w@mail.gmail.com>
Subject: Problems with rtw89_8852be driver in 6.11.1.arch1-1 kernel
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

 I am running Arch linux. When I upgraded my kernel from
6.10.10.arch1-1 to 6.11.1.arch1-1, my wi-fi interface (Realtek
Semiconductor Co., Ltd. RTL8852BE PCIe 802.11ax Wireless Network
Controller) stopped working. I see the following errors in journalctl:

Oct 03 22:35:18 omsk kernel: rtw89_8852be 0000:04:00.0: [ERR]FWDL path ready
Oct 03 22:35:18 omsk kernel: rtw89_8852be 0000:04:00.0: [ERR]fwdl 0x1E0 = 0x23
Oct 03 22:35:18 omsk kernel: rtw89_8852be 0000:04:00.0: [ERR]fwdl
0x83F0 = 0x70000
Oct 03 22:35:18 omsk kernel: rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f47
Oct 03 22:35:18 omsk kernel: rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f57
Oct 03 22:35:18 omsk kernel: rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccd9
Oct 03 22:35:18 omsk kernel: rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f33
Oct 03 22:35:18 omsk kernel: rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccd9
Oct 03 22:35:18 omsk kernel: rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f43
Oct 03 22:35:18 omsk kernel: rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccdf
Oct 03 22:35:18 omsk kernel: rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccd9
Oct 03 22:35:18 omsk kernel: rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccd9
Oct 03 22:35:18 omsk kernel: rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccf7
Oct 03 22:35:18 omsk kernel: rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccdb
Oct 03 22:35:18 omsk kernel: rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f4b
Oct 03 22:35:18 omsk kernel: rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb890ccd9
Oct 03 22:35:18 omsk kernel: rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f3f
Oct 03 22:35:18 omsk kernel: rtw89_8852be 0000:04:00.0: [ERR]fw PC = 0xb8901f49
Oct 03 22:35:18 omsk kernel: rtw89_8852be 0000:04:00.0: failed to
setup chip information
Oct 03 22:35:18 omsk kernel: rtw89_8852be 0000:04:00.0: probe with
driver rtw89_8852be failed with error -110


However, on downgrading the kernel back to 6.10.10.arch1-1, my wifi
interface seems to be working fine. Can you please help?

Thanks,
Sanjay

