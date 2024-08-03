Return-Path: <linux-wireless+bounces-10879-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09139946898
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Aug 2024 10:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C611C203DA
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Aug 2024 08:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B532713633F;
	Sat,  3 Aug 2024 08:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxXDzrKT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C6823CB;
	Sat,  3 Aug 2024 08:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722672052; cv=none; b=bq21ZLje84o6duncVUypzDyFB0E1YAI8wrlU8d9MU965CXlMBe6kofO/JD8ZPghEIJ9WwS5wUvBkmsb+mSzAVCA0tpHrpFHJFRXG762rfsyedv0Z8NhU75xmvIsAg68L3ksCk6EuBPoAHQSCsgbAZAdS5HFLek19Uss0L8U50HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722672052; c=relaxed/simple;
	bh=7BZuniqS0RL8dVXLxoGBLGj9mqSfa5ynEXFo52LZg+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KJv7FblucyFaMcoqc7pNVyifwEc1zNKHfddPDLqJBEE0zV5COMdzpWF6MbxDDpLnHEJdp2D/HumFZvoxdtJk9cVhZyA5ZzyqG964CtUDuSrhmk3GfaFQCiOm10W+gffvMEK1scjLFsPi3njuoTbRIIgscittp43Nlf8xYZwWuQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxXDzrKT; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3db14339fb0so6006278b6e.2;
        Sat, 03 Aug 2024 01:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722672050; x=1723276850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BZuniqS0RL8dVXLxoGBLGj9mqSfa5ynEXFo52LZg+g=;
        b=RxXDzrKTFwVyKZKfsycGI5hmvn3xBpX44eoVdhxd1zPRwJpBj8yJp0MkelhqN23qia
         OFl5tGpu/12zknoy/BQ3J04YfyY4v4SYHblrDItdcu1VRcYXKEVsh1/0fYM8hmJfZ21q
         igDSz9qB4oGY1vJf8vOS8XQn8uO78U0jddZh4I7Ck9fymzhpabD+G9EAjNnKVJx6Yk+Q
         rXbqYR7w2pLACbJkMB2b+gqVXAhwgdfg6wAFILsYdTmO31qU5DXgFMwwIp78271Nq991
         6Uf/G1O80xutaAtBLdzFh3wHiCOrd7Dcll0dN0b4Y84bcNuZhnPKZJnbP8YjOO91PuB0
         0neA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722672050; x=1723276850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7BZuniqS0RL8dVXLxoGBLGj9mqSfa5ynEXFo52LZg+g=;
        b=pCpiiVaNgJDaC6Ubbv8ml4gZihyUddKENOrN+XJDggfhLd0H1gcO9HC+1RhnCsevll
         zhwTDKIX/Me+ovJmXoGBYYJ9mCI202h7eSmi1TW53frjGxUFNqwee3hFr6mMl9ZWFGFN
         NrKOYgux4LHsEOkchRl2uBQP41nyqsSgHWzpvBrKbTe4CBABI4Q8VNPyAJyD4x4PFjpL
         3Wr1hjIhYKLBzh2umUpWiQj81dr1cC/kCGLtyy7FOHbaR8bdksmNVG10wIsajsxZdNpO
         YKyFUVcr5pA3XcMWR6OmlnwTR0KPOz20/Zai4jnCw9tPMn/OEif8/rNfsE403iyGbSRs
         FIfg==
X-Forwarded-Encrypted: i=1; AJvYcCUHkUzCrtO3H4/7fYXr5CbTQooH0JjxS+cuGQCPTEAGHJBYkkh0B/QYe3bfAHym1zK6V44i2ebbffHO7D6SJwo=@vger.kernel.org, AJvYcCWvPcjEZcaoA7zcYrb5JbAqjeHUVkahxFdYCH9bmnzsqbFPAIcEzJIxCJEli48Dk1bse8IZgBh+5nz0p3k=@vger.kernel.org, AJvYcCX4WqwNyn11PLoeZxTgEUjs5Opxl6JaFNunBe9EVSurP/mVaZv+TWF26dMxNKd2dqau04A3oC6Qnt1V@vger.kernel.org
X-Gm-Message-State: AOJu0YyLXBVIo7CvnzU6Kr6+Q+1bPJzSzulkqLeTSEDZ+PjjiRK9n+Ig
	GJ+wVV40zH25bIpF1mCGkEFTYCXTL4ukK36qTmjRlvDJ3Y0CiV8=
X-Google-Smtp-Source: AGHT+IEr7ERk/naO0Iz3UIs9XYIXEimYpZZhriHvIC07pbZhLt3+1M+ito7FYGETjelVqDpu2Vk6sw==
X-Received: by 2002:a05:6808:23c7:b0:3d9:c48b:ea44 with SMTP id 5614622812f47-3db55809c42mr5974053b6e.15.1722672050339;
        Sat, 03 Aug 2024 01:00:50 -0700 (PDT)
Received: from swift.. ([123.122.138.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5905f9b9sm28804935ad.130.2024.08.03.01.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 01:00:50 -0700 (PDT)
From: LidongLI <wirelessdonghack@gmail.com>
To: gregkh@linuxfoundation.org
Cc: kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	mark.esler@canonical.com,
	stf_xl@wp.pl,
	wirelessdonghack@gmail.com
Subject: Re: Ubuntu RT2X00 WIFI USB Driver Kernel NULL pointer Dereference&Use-After-Free Vulnerability
Date: Sat,  3 Aug 2024 15:57:23 +0800
Message-Id: <20240803075723.1452108-1-wirelessdonghack@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024080359-getaway-concave-623e@gregkh>
References: <2024080359-getaway-concave-623e@gregkh>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,



Alright, if you have any issues, please feel free to contact us. We believe the issue might be caused by the time.sleep() function set during packet transmission. Please reproduce and investigate."

If you need any adjustments or further assistance, just let me know!




Best regards,


