Return-Path: <linux-wireless+bounces-18780-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 593A7A3119F
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 17:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CEC418848BF
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 16:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05150253F0D;
	Tue, 11 Feb 2025 16:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pp1aP8m8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977FD24E4C3;
	Tue, 11 Feb 2025 16:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739291655; cv=none; b=mzukvdp9ITq5VGEy/GpIYnGZuomUy2sh6rId58OQ4dUL+Qzr/cNytwsKlr4oPmOHgXn1eQNGUuuDKUz7pImD1VGZr4ILv1utof6KwqRkJSEH/W1layjA7zT0qywcVxWmh9cDg8WhMw9N7O7tD0Ywk5339xABe4CSb6JEgpDdYyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739291655; c=relaxed/simple;
	bh=v9zLtYVKdZh0APwPkClRT1ytoQtcPi31gcSlauDEj6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0XQoTVxtY6zzaSQ/owI3S4WiKpLLPEq4UWbvfgHPB9OuYxYCo4uc3HxGua3iWF7T6vavkhOlAZVOuPBrJfWCmY0QS4HVJfVxlotwoKYpiShJzHqAyHzSDaSdGY+tKfcQON1M+p8zQpap9LCiJLvlVGqeCAo7aCHVHsulHbpatM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pp1aP8m8; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21f7f03d7c0so59588545ad.3;
        Tue, 11 Feb 2025 08:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739291654; x=1739896454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCvaWLA1E4CzjqUu9l+t753ewbJQ4VFl2FPDikYcRnQ=;
        b=Pp1aP8m87NDk6E3Km12qTb61DD4STbBF7LUubXkVSZJR2pbvwxwX9bIgwa/pRHWZHG
         h/u7NL+RvLdaouefprE89yiN4u6PAM5JLlYF9YVEa6rLruNLJzoawaek5tgxJHruP9oN
         PWTR5kiTKEuqXWKAhJtbJxs8K2gGfXcw66NLQtzbnZNoqT98PauEEg4duof+6IfEHzG4
         5qYKATyTsop9bUuvBwyBm4E2tllgUBHZNo3YGBDRPAaAVVdVWlc2d5z54O9jbnI/wutm
         vS4cjxbgef6g4d+d/Pe1GJ+9bRI6+Of1M833qP47QIlYYJ64ZCgEcnDdCwcHo9jldRp/
         vKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739291654; x=1739896454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCvaWLA1E4CzjqUu9l+t753ewbJQ4VFl2FPDikYcRnQ=;
        b=hGVWMAWVgcGttCB6Bgkuy4DCjXzeT6m5Lml7NJwOxf2xDg03rBSoS30v8+c3zXL5q+
         inqsOd7t+lXFDff0R5oqMasU0skwb1PyeSFF1M/X6E/QdkpTXxj381obQNiRnSdcr8Cu
         EWhAjozGHKXhPPWUMqfKEa/7btZJtDuyXBeG3wb5zteI57QyQbhB4rgUyPCn10Oz17IS
         alwmRBnYCXWqcsDjakmo3Lp/qB50Rj4wAhGPB7yXeHN8ZQxkFYOgKO2vu4tERJGJFuKR
         TIkuCd/oYx4Ilj7NfM3tpUZrtErp2ZR+v1bWif+eEC2p6HXViQRWBoTb70lMkZyOvs5t
         60OQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUiwIVqwSoSCW2gnojDZ+JCsxSUUk4CFBJRZW9a11K/rBtbAOYwI09EL5aBWll0mFLUBr9TIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHdFWMjUGsOodKWwpCnDiH3fWAltiwrducEhgkjzTIi6CxlrZp
	Ic6yrrMQgRzCD1L8fgvXs35HE8/vwkSQ6iN87KTGCRWvQatUDU6nRJcB6XF3e64=
X-Gm-Gg: ASbGncsJbgEUlK9RfDucfqu3u4JIpXIw9+jVYYb4OhGanHynmbvbzQpQEaZAs8k3rsP
	vLVyvnYQRDdUXN17EJdfqUvItmQZOxD1G2P371crwSI3pQYayfyab7KGVHco8gBhVBwohcx/jDN
	lBv0qc6ebYL+6+v02mJ8bhjSQn+8ZzDwlyw57/B9Ug8xKtVkaKkycytO2g3q52LZ0twAMc+qve7
	bjt6LGsC1FhSgFpYuFDa2S62hi3DBnsVvOaLApj7tYuiygja/UuUpiNUOgfFTTauUNR1tsjbgq9
	LUBUqVsttn/vvmg2BBBaIT7Yxv15KyFOt25A1Q8jeV6aNXlApLUnV7nqIhFQT/MojA==
X-Google-Smtp-Source: AGHT+IGjW/zCkX97HmZHi26NEipPvk1XdZKRzP6dBliNGPkOqdivQDCCF0Rj2L8R9nq2pYZlfU1Uag==
X-Received: by 2002:a05:6a20:cf83:b0:1e1:9fef:e960 with SMTP id adf61e73a8af0-1ee03a24b89mr30282217637.6.1739291653442;
        Tue, 11 Feb 2025 08:34:13 -0800 (PST)
Received: from localhost.localdomain (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-730aad5535fsm2716349b3a.51.2025.02.11.08.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 08:34:13 -0800 (PST)
From: Zenm Chen <zenmchen@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	stable@vger.kernel.org,
	zenmchen@gmail.com
Subject: RE: [PATCH v6.12] wifi: rtw89: pci: disable PCIE wake bit when PCIE deinit
Date: Wed, 12 Feb 2025 00:34:09 +0800
Message-ID: <20250211163409.1177-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025021143-neurosis-snout-c9b3@gregkh>
References: <2025021143-neurosis-snout-c9b3@gregkh>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> It also needs to go to 6.13.y too, right?  Please provide backports for
> both as we can not take them only for older kernels as you would have a
> regression when upgrading.

Hi Greg,

Thanks for reminding! The patch for kernel 6.13 is here:
https://lore.kernel.org/stable/20250211130432.1091-1-zenmchen@gmail.com/T/#u

Tested with RTL8852BE on Arch Linux (kernel version: 6.13.2-arch1-1)
and it did fix the issue.

thanks!

> 
> thanks,
> 
> greg k-h


