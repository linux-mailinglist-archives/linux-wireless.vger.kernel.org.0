Return-Path: <linux-wireless+bounces-26915-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAFCB3F2A3
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 05:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 161DD1A853EF
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 03:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152232DECC5;
	Tue,  2 Sep 2025 03:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHA8/fMe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD1E2DECB1
	for <linux-wireless@vger.kernel.org>; Tue,  2 Sep 2025 03:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756783317; cv=none; b=u6TzKmXCz9WxRoa+stLq5/R1CiP1qV0MwHIWd9hATdXx53Ts4kdIsEgY1ZMjdcMNGhBzOs2N0HDT2Y/80Ogi1wlDPtmnvLyvvdQ5/yjpVWx3jB/zy+ZHoBEKpFIxBlijoXbxCIQnczEYWP0VYDVLTUF1IE4bHDrkNQejLdL9738=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756783317; c=relaxed/simple;
	bh=B9UtVt5T9xwCnl3su2nDtZC+hz7c7Pd+IjYgfFLaOYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQfP3E1PSBYZ1AVk0mQKH+z8KAleuorbPTB24KfL/YqSMTqNuDW8JZUGrtsaPlc67UhoNDX6z8Jzf/kj374tyDBP5gFbrkHiU+DB8XdAz/mm3iJoWZaXc+gGuiadFjAuAY3aU6AUSqYZSI4DAmXd9VYzC/DQMFfZ/hA6tzD78YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHA8/fMe; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77238cb3cbbso2481151b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 01 Sep 2025 20:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756783316; x=1757388116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9UtVt5T9xwCnl3su2nDtZC+hz7c7Pd+IjYgfFLaOYk=;
        b=JHA8/fMegP2czVi8WbIrdYxGO/3uBGvexU/l3tOf6AqMIsIKgPss4jJwebR5iJZMkd
         t2NsS6dQ8rlwBrmtAu25Uw6SaZYy6SgalfdYM60HEWC20aCQDWc84UKTV3idLOqmAPOn
         j4IMotS5MBTUZyLKqsYGftsfQu27YY9DqBYbmL+SxxbqgSsgpVfpYfT8BsSDXW/Mh6C1
         o+WjDik9ksnyP+5nTTN/E5qVHQ8RZ070jIB5b+jANW7UDRq7LYi/TqU51nD3VpqoaW+s
         086IpHnIXBAoZz3bR2zRMcC9IlJI15H/8oMA+xvC3XewlM+lCMqw9fkN5vnIlkaE/+Il
         E0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756783316; x=1757388116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9UtVt5T9xwCnl3su2nDtZC+hz7c7Pd+IjYgfFLaOYk=;
        b=LI/Ou9jw8JAuSPvNfewgZCkLBA09xJNkIy/RAN0zwhe9vQ0HAyRgKmhJJhSN+WL4k3
         eLAa2WHqbwdnWEeIESxHIWNyaGSsUhbuKV3RkgJqINRovtPystbN9A/RDOCpJi2xWxz9
         udoEiklTmQ/lIE1Vf9jpOU3ICry+1Z5CJ4e3312eYdaX9EdimVFrfDNWSHxCj8QJ85Lu
         qa/BBN+MUN6hxHXmjsTR0IlGZVkI7ttkmoyI3KMKrvcUhik0Kxe6LiIXbA+Iq4OJdqwm
         MfJuoe+dANg6eVnLuma/PBGsFrgeE4ItfXNz6qaqn+sLkM28GLPZqbuCsv0E1/9RBQge
         dDxQ==
X-Gm-Message-State: AOJu0YwnAcO5uJIn8OLAm/dMChPBl7eAOcawERO9TkCIr0wXNEaTGvBj
	XVMz93zSuDX+G/Cbi+f2dkVfHLpmCsEifdftMzEsvgS4Q9vOf19xzhSU
X-Gm-Gg: ASbGncsQys6i7saH+sIMZqmXIRdukNS18ltFbHZWra3jz8PbdpKLb12VkowQoDEs4xH
	BFbVlMkT6mtsO6fvBNb0TBYi71QBi07In4gzmbugNIg8ecAFKhG/W+il98r6bhzs3v/qIvlQ+kT
	6ic5sUEbPziFS768C7aG4U8cdddqE7E+z8xPysRbzb3x7wCRiEj0uK8tTNQJCmM56U5rwTHgCGd
	H9p+s6gaWh5MSQwz2/TLLfpG1hJKwBGeU8YaVj04urSIL1gutnVeFIwadvmxvOA4i6qQWTUp2vh
	bc0IywoKN7wws+zEsmh8rNOBPOjTs3XDxWaHIhUYiFEfPgxslHj8jRocmXigineRxQgMERZQvUf
	tOUtEz0iEKaeImAiyfFprOcO0nZvwr8lF8AJ+GEW19nrRWNu6cezc
X-Google-Smtp-Source: AGHT+IHCUEB3N93Ku3huFpwA4er1m7ascbkymb5dkTKNn5eFkf3WFnqj9uGEohAwMlC1TPg9HPbyLQ==
X-Received: by 2002:a05:6a20:3d07:b0:243:c2e8:f4d1 with SMTP id adf61e73a8af0-243d6e6d928mr15142957637.26.1756783315691;
        Mon, 01 Sep 2025 20:21:55 -0700 (PDT)
Received: from BM5220 (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b4cd007026esm10579822a12.9.2025.09.01.20.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 20:21:55 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	rtl8821cerfe2@gmail.com,
	usbwifi2024@gmail.com,
	zenmchen@gmail.com
Subject: RE: [PATCH rtw-next] wifi: rtw89: Add USB ID 2001:332a for D-Link AX9U
Date: Tue,  2 Sep 2025 11:21:52 +0800
Message-ID: <20250902032152.1968904-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902030207.1968706-1-zenmchen@gmail.com>
References: <20250902030207.1968706-1-zenmchen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ping-Ke,

Please drop this patch, I found I put the code at the wrong place.

