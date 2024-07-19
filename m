Return-Path: <linux-wireless+bounces-10398-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2C1937D76
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 23:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B37A2812F7
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 21:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152D0145B34;
	Fri, 19 Jul 2024 21:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k8r22iWO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E812BB05
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jul 2024 21:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721424368; cv=none; b=IkfRU7vAjyIsB66BGnY9ud64JltmOpp1/YvR7+RfshLmFJ/7rS8mO+ImEU5Tdw7o6AG07Iy5LmiFKEYDENufegWXcuTRsFsk2mJ4qFpmjyhMudbqMBnZvFm+nuGkCh6anQtJCN0GIP2zkIUhoYr6RxUfzKNTabOp07JUemJGUyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721424368; c=relaxed/simple;
	bh=rIUIudV3W4EelKHjVdbAz3TupXvxJb8HU8cRrgggIwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHm3DVs2a2DWf7QKOy6rKoWUPTZr/DtAX9YR4m8Kmkl0IajvhDrGYp2iFN4mX06A/LTtnmMJuIVDBMPryZ1xJouF2dw4o73dfcRk61guzFXQAJAbVjYSAT97C0IniaoHkXdJl73lMkeG0ovpRGeF/p++OSsQu5vGPoxPqLba17g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k8r22iWO; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-80557928673so96879239f.2
        for <linux-wireless@vger.kernel.org>; Fri, 19 Jul 2024 14:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721424364; x=1722029164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIUIudV3W4EelKHjVdbAz3TupXvxJb8HU8cRrgggIwc=;
        b=k8r22iWOuyWIbuqQ9N2a38UfiAtjMk4NggwWSN3kxrcDIxIaOyxscwpKOeqwKuJ0XI
         1bi6YJPGBDjtZkHR+FS63QkbQuab9N9LzCx1cLMpmemIbmvURcszHPBbc+wCgaAAo5Nd
         ilzfpwM7IeWoxLJqNo9mGlv1jqUEdh/uRJA1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721424364; x=1722029164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIUIudV3W4EelKHjVdbAz3TupXvxJb8HU8cRrgggIwc=;
        b=csWT7qZ7+T/XhSjsrvcf8VR7TAe6CC5eM7BW+KvshhACwmdZlWUMK4Co4CEx/KvGWj
         2jb/ZSE2r8+RCGOrcHUJp12yCf2qnx8P0Wj0SAXwWWtDvjhrSh9jCfYCA6G5+ue9SoJa
         VzVNVqfZ8N/cwSw+l3GX0rDGgkuJeoVHy8C/bn3zHbXIYNdEdJry2nKSqq/8GIKEmWQN
         fxyWEFH+JgNVdrv7ra+TO6ht80R/R370At6Bek3PoHi+4NzY7mxMprqmCrkU2EXgI/mz
         qiBA5wTXCOi6V5MToas0vJzlBsmDSq8c9oYIP0a6jmvYS59aL0C+9JW22WU+epgAlx2v
         BT5w==
X-Forwarded-Encrypted: i=1; AJvYcCX0LfrFZ3QlUT/7K5vkvO+D+m5SklHeJgZ4OGiKpqDItqaocJkCTYozj/Qwjxjj6WzV8JSTAL+ULq1Gg0mlin+j+76Z+NkqBvByO783ujg=
X-Gm-Message-State: AOJu0YzA9UtseQ0oHP8j6WEmNVvq9QmY98fsyMBQUTfL/TWQWZABwN2t
	tFgt7FkZZNugHhlm9bVnOj+IxkmddwQn73/P+CKd5fdnTzFKzxneYLW41tTnmw==
X-Google-Smtp-Source: AGHT+IEiTPDsV72AfgDxBbXkqBMrB1vv3zaXpnz+M6Y2UShrsiWah2qsgNBOmPFY5+0G0fmtM4R9tw==
X-Received: by 2002:a05:6602:6c1c:b0:80d:19e4:9d63 with SMTP id ca18e2360f4ac-81aa4dc3a36mr144818839f.3.1721424364015;
        Fri, 19 Jul 2024 14:26:04 -0700 (PDT)
Received: from arowa.c.googlers.com.com (214.62.225.35.bc.googleusercontent.com. [35.225.62.214])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c2343ab449sm473825173.113.2024.07.19.14.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 14:26:03 -0700 (PDT)
From: Arowa Suliman <arowa@chromium.org>
X-Google-Original-From: Arowa Suliman <arowa@chromium.com>
To: mingyen.hsieh@mediatek.com
Cc: Eric-SY.Chang@mediatek.com,
	Leon.Yen@mediatek.com,
	Quan.Zhou@mediatek.com,
	Ryder.Lee@mediatek.com,
	Sean.Wang@mediatek.com,
	Shayne.Chen@mediatek.com,
	Soul.Huang@mediatek.com,
	ch.yeh@mediatek.com,
	deren.wu@mediatek.com,
	km.lin@mediatek.com,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	posh.sun@mediatek.com,
	robin.chiu@mediatek.com,
	Arowa Suliman <arowa@chromium.org>
Subject: Re: [v2] wifi: mt76: mt7921: introduce CSA support
Date: Fri, 19 Jul 2024 21:25:48 +0000
Message-ID: <20240719212548.1121903-1-arowa@chromium.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
In-Reply-To: <20240530084455.4290-1-mingyen.hsieh@mediatek.com>
References: <20240530084455.4290-1-mingyen.hsieh@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tested-by: Arowa Suliman <arowa@chromium.org>


