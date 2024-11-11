Return-Path: <linux-wireless+bounces-15172-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 497869C3904
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 08:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09E371F21C60
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 07:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8452F15A856;
	Mon, 11 Nov 2024 07:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChLqSklf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8901598EE;
	Mon, 11 Nov 2024 07:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731310009; cv=none; b=bdpsaPfKL5/04jJg4XL1TJf9nD9nVbLaXEj97LOC3rO0BvP4YkE7IoRVsu+qB0IZH6XfGRxWI+b1PadTk2J7GD3VFckEUocVXW3Oebdc48hFqYFk/9qObsQcMcRXKCze8Oamp8RV+ijD1nNXxyIdad4UQ5wNz/A59EGD3e4ymww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731310009; c=relaxed/simple;
	bh=sfm8rylacmD2PJiYt07iabqtGz1/OiNWA1YlsbbJVqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HwxkXD7+8epPiLi7hUQm68MTD4GqU1NHgughM+1dq8F3vRzUoCp1bNAwZMjFJsohas4xLF+QZ2e/cKgBrhgA2/ABVrDd65hBXsi9C0Ob1BYcBUYiTzpKHpTC29btkmbLUF1Y3HsSieSJUOqAFV0uBcbtlpqjFP91hhJKUvty/20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChLqSklf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c767a9c50so39767535ad.1;
        Sun, 10 Nov 2024 23:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731310007; x=1731914807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfm8rylacmD2PJiYt07iabqtGz1/OiNWA1YlsbbJVqQ=;
        b=ChLqSklf+rj2R0oEaQ6w87VF9953pLw3K0/impUNWzx/0iZEEWPV2XrL07J+YiO2HV
         qt8LuTXfV7dM8KwjBAVteDLIdQKxA8SwXswJI9ZjIuIvvHiNxt9lw6+k84l1IhAmFaIq
         OgCJKlYT+XF42mcNZ5UYmcE1B7CVWUyYSNRb1ur70MCPYnq06rwQkfvoOjotCpts76a5
         I8sA4I3CedbfAofJ9OQS9oUsltpwjr6+Ef9NdvD1KBHvcrF/iGX1O/w70COmmSiWq3Ak
         MEiu6FKJIxAKW0pRYyPmq2FvtBkLX0S/rGfQyLnM85/z8NGfGBLIc5S9EZdCUFpnn7Ku
         BE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731310007; x=1731914807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfm8rylacmD2PJiYt07iabqtGz1/OiNWA1YlsbbJVqQ=;
        b=W3p0tX9MLJyp9uji/7V627/f47vcSQdfdxQAjCH3bUNrJkTcFOvabHwAVmYHpz34KX
         iKahbvzSBMgNMpD3GUxsNxsAGMW3UQvA0uZP22kUuJmcS6h5zxRhGl5c4uvnkh/Q5iM/
         5YpUlixTqpTi/f4VdxWGkQMP02mrmI5ffonxcKvD6q70hJOWT9Ngt5kbN+m+NuxTSpi7
         Nsjo10eK6yZjRyysxL/jU0MwLkPXyZDttZEcZlwuc8wvnOb3MjMLUvxU/z8CNe7CQJkp
         yTHtr0CB8Y6w3hfESg8mQ4xRMt2z858NzNQaLkyy8R6RgsuAS7UDvmdNc+pqxDmavLOQ
         r5zg==
X-Forwarded-Encrypted: i=1; AJvYcCW9sqFPPdNEp0/tk64kKBY131kiI/O4abz0YdV8xw0T4m6bXZArkc93bYqAeaAA7kOBOjVLAlr0wDVMsOk=@vger.kernel.org, AJvYcCXbfI5OJdh81c4YN9aO4XXSbi+rZskNXFuChkJ10xL3R7cB/wSerRC4F91eZxyzQA5cOv3Mp41Vmhaj5s/QlkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjgk6HLjgHhlMdu72Kod18UP/RIlFd1sORYayiUkcS1cFJLtFu
	+pp0+m32b/TUXACWRj9FZ/oU9jZ5mAZty3AIdC1Tdv0bZBB4gUsr
X-Google-Smtp-Source: AGHT+IFwVIGa5j8LUcLTwCibFln486Ieu/yqao3Pbwevow6lq4eVjiTHavXofumhrvu8EHvskGvh+A==
X-Received: by 2002:a17:902:f705:b0:20c:61a2:5ca4 with SMTP id d9443c01a7336-21183c7d651mr154702015ad.10.1731310007076;
        Sun, 10 Nov 2024 23:26:47 -0800 (PST)
Received: from BM5220.hitronhub.home ([2407:4d00:9c00:839f::9fe4])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-21177ddd637sm70172985ad.69.2024.11.10.23.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 23:26:46 -0800 (PST)
From: Zenm Chen <zenmchen@gmail.com>
To: m.novosyolov@rosalinux.ru
Cc: kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com,
	usbwifi2024@gmail.com,
	zenmchen@gmail.com
Subject: Re: [PATCH] wifi: rtw88: Add additional USB IDs for RTL8812BU
Date: Mon, 11 Nov 2024 15:26:43 +0800
Message-ID: <20241111072643.5142-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <57d4fa02-0b03-0a46-dc97-320fa5e5b540@rosalinux.ru>
References: <57d4fa02-0b03-0a46-dc97-320fa5e5b540@rosalinux.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Mikhail,

According to the guide of submitting patches [1], "Signed-off-by" can only
be used by patch author and people handling and transporting the patch, so
Ping-Ke said he may change your s-o-b into "Reviewed-by:" or other suitable
tag. We would appreciate your kind understanding.

[1] https://github.com/torvalds/linux/blob/master/Documentation/process/submitting-patches.rst

