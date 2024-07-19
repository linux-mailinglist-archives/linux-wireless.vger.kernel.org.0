Return-Path: <linux-wireless+bounces-10397-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79132937D66
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 22:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 305C428166C
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 20:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7722C697;
	Fri, 19 Jul 2024 20:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fY3lDuiH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766901B86EC
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jul 2024 20:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721421961; cv=none; b=DEJXk8Xaak+3vm+aApcI6pfEfsFQA/c8acePEI7LIhxipYPgX8IJ5xvHXKilDTqb3fdAuzqbjoI6rrDt71vuqDOpdbbqVKlb0Fsk1WIzgkgznplaw5HRuChNCE7u94BoHC4ipjxknPXKzTCL0xdhvlZJtUVLQg+5OEVMzhkfJTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721421961; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gP7HekHQLeRfz51LXqPcMyzdnQjJZNvTrWN7/QhsvKg35Y3hJCaaATnN+kXksdPzltM8n29/cB9Lhrb8eWJbCz3148RDdBo3OaUj+tkajK5pzktqng6v11G8YqQYXT3Ihr+c3uJy7uaOCZjSFbztlwBO8dt4fP+YthN2hqINzv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fY3lDuiH; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-816b627a7b6so84832639f.0
        for <linux-wireless@vger.kernel.org>; Fri, 19 Jul 2024 13:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721421959; x=1722026759; darn=vger.kernel.org;
        h=content-transfer-encoding:tested-by:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=fY3lDuiHCU2a4ObTpu0+di8bKSiUcVVxGex9q+n/DZ1W5BpL3mcoxpwCK8gyldggYc
         fuHxcGse5SkYNJYvr7snJ5fcXDURocsAg6xj/Q2DXGjhVk8iWFx/4dlxL/hG32OcGHNR
         2W5nGmFbyRebWgq9wDvojyn6CdaRmF/Mf9emI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721421959; x=1722026759;
        h=content-transfer-encoding:tested-by:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=XNOnGhUI9fvlI48nHKnvCp8NkHWw03x7WsiGoTem27eNW/6USuiZTsa4H7PP8lkHyu
         A1fOF7HushxEiOk1yiFDYz+hC5mvpdHgv02e4xNfH0UrOu8D65iXzMbsrTqiYBPh6UkG
         eIPf88btR7OxnHN1hgkJjAyVroPEihX2ptCmRx3qcXF8Bwd8gt0seMfIx4vEsNZAg7d9
         tsbKiNkJpqWRACts52CArABVMj4J5Da+teEgXcw/csOoDc3Xy9YG3rD6dK4RXqwq73D6
         dTUpBE+L6KzCIweJWOJ3HqO41Yn1wHLoPoJMfjfUTuow3b/ikjadYImV2TOeyAVn3A7Q
         Lkpw==
X-Forwarded-Encrypted: i=1; AJvYcCVa3Sb0v+i1zm/1iegcFWxxEBmT+Lix7f2yzsmTCZha/MWr52ffRB/1S1339EkOWBxG9gXK8E+BGzvPz9Ahyl4Cjx0exh1GJgiwUEvSEfc=
X-Gm-Message-State: AOJu0YwtQXVd4daDxvpqxVhdo6GwNPKgsNfZAfFxy78rIgRs2qsANqnh
	Y6CVFLBvNYRvgXSK/Fb1LrPD/kdKta1XXaABOthJjvjR9lZvugP+d6GP+NKhVQ==
X-Google-Smtp-Source: AGHT+IEWEky2R8AmLgCPI7m4VCZ1SzL/kd0LYvnZoSI1Au9xSLRjH3/gDGRwPRdrVeeIMeSHpOLBWg==
X-Received: by 2002:a05:6602:3f91:b0:7f9:16da:ac79 with SMTP id ca18e2360f4ac-817125e31c2mr1240441339f.16.1721421959663;
        Fri, 19 Jul 2024 13:45:59 -0700 (PDT)
Received: from arowa.c.googlers.com.com (214.62.225.35.bc.googleusercontent.com. [35.225.62.214])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c234404f4esm471700173.162.2024.07.19.13.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 13:45:59 -0700 (PDT)
From: Arowa Suliman <arowa@chromium.org>
X-Google-Original-From: Arowa Suliman <arowa@google.com>
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
	robin.chiu@mediatek.com
Subject: Re: [PATCH v2] wifi: mt76: mt7921: introduce CSA support
Date: Fri, 19 Jul 2024 20:45:56 +0000
Message-ID: <20240719204556.1029453-1-arowa@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
In-Reply-To: <20240530084455.4290-1-mingyen.hsieh@mediatek.com>
References: <20240530084455.4290-1-mingyen.hsieh@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Tested-by: Arowa Suliman <arowa@chromium.org>
Content-Transfer-Encoding: 8bit


