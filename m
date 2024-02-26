Return-Path: <linux-wireless+bounces-4002-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0DC867180
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 11:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E526FB25DA7
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 10:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFF445C15;
	Mon, 26 Feb 2024 10:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ie+ZXtEo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFF31EB2B
	for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 10:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708941750; cv=none; b=lMjyUXKrs6GwFe6R//972HkrZfSkQHOwRqkvApK28OXhzFUKvbcI1pFwoB2NmeaixwdGDHY0BDkZGYCyXPeBa/quv8bSMr4nXeCSNePwyjVHTy+KbBBQwcRSMtSdy0QFCG4nU5GZcWwd5TdCF2b46SDpJZzDZhlcbXY0XrLXrY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708941750; c=relaxed/simple;
	bh=fIxN4GeE0ed/jnenroZPKgoAUMxh0aPBcbxgE129NA0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=opjbyvPlqoUFZHSfxjJFGNXeAgTC4snN0P9j4Sy5pgqT4v0gm90fGD5KcG1syNygq9dawBXUY4O3hIWK7wT0EDZ3K6VsF2qotayxhMiDzGbdW5kR+EkTHTXda+3RNcybAL4fmWP2MX2D3ooenN/5OsLaVP/maZRA73dXGU/AS4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ie+ZXtEo; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3ee69976c9so352300966b.0
        for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 02:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708941747; x=1709546547; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fIxN4GeE0ed/jnenroZPKgoAUMxh0aPBcbxgE129NA0=;
        b=Ie+ZXtEo0sRGpA1FZIgSnvkSZZ8QaNNvld27MPGpvldwc5h9u8QXxw6nWc0TscUzhl
         LjPqwpybbke0aI9HYkWR+6SvGxwemKYtDOt0JM+JKJUFcYy3igGWTRAYLNNJ+vICn9cF
         SQR6E+bNY7uh+GMmZXzDpcpU0ifARJt7Wql2KKJ+yul8XGO8Pgupk0BMy9Y/HkWXmqD5
         ZOB9tbwJg0zfEhGe7/UGAZozzfgA2eP0AiF2PJtF/fc03cdtuYi0/QqVbwDUWauk7KDN
         0FTrtlZpm0U+5C6xL1vBUQe1f82HFzQkTI/wSzOoVSSKKeVQPkdy6mAk6zOJQzxEnPCr
         eRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708941747; x=1709546547;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fIxN4GeE0ed/jnenroZPKgoAUMxh0aPBcbxgE129NA0=;
        b=cTu0jbyt6QQ6A1cYD1hK8Ilo0DsNFTtfQ3lWOeFaRTi2FKHZ2bBdNS1Dv4VjxPD7cO
         J+ZlfeGRuQIrUsUp3fTcrBIxUutycupRoAQ2bn5167gmwJBTJZ0HOeZtPTATPglWB2d6
         RqqZhGBjXmrO3UYco0tm7OHPAK0yxcVmovQjWIMt1LWgwwp+vCSIRyr925vkz0zYqncd
         /oUAmrXtvIKWtcHdmSHrBaIeIGoRA0EoImpKOPCadZUo9xBAfkD97OVypeWSOhvMMztQ
         Xi263YLPxVQdwUlwnB+Tq4HaCS2ihdDxcJSzVn+Mw9VsgAYb5aU+pNH16vw7/aNXXPyl
         d9sg==
X-Gm-Message-State: AOJu0YxVW65PYATSHlLWmNCfUgcoZRsliXmJzeNywxdTdqFIxuAlEX5R
	0vUBjZw20D9LCBJhHEijVMPDtTM7b9sq9M/Dmqkpx4zspiDysghu8DXJjQ1e7mB1ivFd5Gq5VA8
	bhDXI3CoKy6rYoKIBMxzmunIxG04CJHeO
X-Google-Smtp-Source: AGHT+IE0uVeoldPgRg0FNjIU/d2aZhndRwelTFulwV6I+mhNpyvC6WBcsa4NBF7nEdGyoarul865hHMKIekj0CgYhyU=
X-Received: by 2002:a17:906:c307:b0:a43:1099:7e7b with SMTP id
 s7-20020a170906c30700b00a4310997e7bmr2568879ejz.54.1708941746773; Mon, 26 Feb
 2024 02:02:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: James Dutton <james.dutton@gmail.com>
Date: Mon, 26 Feb 2024 10:01:50 +0000
Message-ID: <CAAMvbhFNBGF8h9z=ecVWQk4w+J7G7P=9vz5mh2KvpRNyx-3b2g@mail.gmail.com>
Subject: Intel BE200 Wifi 7 card.
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I have seen lots of reports on the internet that say the Intel BE200
does not work on AMD motherboards.
So, by posting here I was hoping to find out if anyone knew whether it
is a fundamental hardware incompatibility, or whether it is a bug in
the software causing the problem.
Intel's previous Wifi cards like the AX210 seem to work on both Intel
and AMD motherboards
, so maybe the BE200 is not supposed to work on AMD motherboards?
I would be surprised as that probably cuts the BE200 off from about
50% of its market.

Kind Regards

James

