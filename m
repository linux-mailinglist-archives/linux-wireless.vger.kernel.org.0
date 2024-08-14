Return-Path: <linux-wireless+bounces-11438-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31021952050
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 18:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635C41C22676
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 16:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A8D3FB3B;
	Wed, 14 Aug 2024 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sr8I+oMB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948041BA888
	for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 16:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723653940; cv=none; b=Q+bASBvXCthgie+LguFGV+YmZ2rAQh2xplvm3W8xZDqJNVeH1KxYgcRMGsSSV18isnkVN8EHBolwSXSpx6dUu3umHPnLDekcspGFYmeGjQFiOS6LG7VmVD028Jph+mH79TVPTkh58hCKbQr8CP4N00OmckQZUWXarAECm3AWPe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723653940; c=relaxed/simple;
	bh=NmoA2bpmUWX8zWrCtJ2nkSz0fKqymPWvjBYDRxrlKrM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M1QGhCRJ+Mw5EDbGnTuOhChwkth5CTz/vHk206K7Rab0cUJRf4LbLDBg/0mGlJG8wN77v9kI1zIUGwQ1v4MxJCYP05Z+WZrrIkgXQIbKom5hfiauQC6Ys7e2Lvmvhlo+5sfanplzrqdplty2aOM7RXWFuOxsVazqVqcCIi/6Bw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sr8I+oMB; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso120415a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 09:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723653936; x=1724258736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D+tPDiTXkWJj5I1HhSQqqfRMrtmrsXTQDIjEBJRLwdU=;
        b=Sr8I+oMB2nl/8UjoAhVgKvgiiq/gYo+/q+GA5ZZ4+eZOiIVMY6AoRJf6MUG9masb67
         b89Nk4eABZ5YyWgHQN8LKCN0AhKVVMctPfdOrHJzIflkn3igdK72hQePlhDeUPxdG2fs
         EWMDWu8cnDvqd+8YQOKSwT39rqhVTfMyj6xazVwje1uahGY21lJ+p6/2yuDG3VaKvkX7
         Tkmkfm/H9gRjt9jgFIkwjwQMy2RafwPdMHBdmWwdBOGZyHcFNJjhmY8jZjpW0lfuiMgg
         OG9cufXhIEHVw4H+IywxJzbY0sqcPleXXRALf+wZE2ZhxM8HYZM4+2inpyHT1jOrt/1k
         rTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723653936; x=1724258736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+tPDiTXkWJj5I1HhSQqqfRMrtmrsXTQDIjEBJRLwdU=;
        b=aFa9S2b9lE32f08DPkjqv4XMdyPl4RCJeUgw8ro38dO5ktLLxYeNfajG1gqOjyJoR6
         wsVvpqRJvdNMCPGDo9hvooeUI4fGRh2Jj9pXGpDf7aEUvssNWunLBedDzlUkIGAKPJyq
         Xu5qvDgHkIyfMczbj4OwQr71duUozEBdjPm25r9jLA7Vr7MO68ShKbTP5ZlcjmQdDVWL
         Tart8uvPhn24LUbvk9cZXDSdfAo9SaChSqGSEnjN0ihdap5cMvsOvYLnHLQtvmhMpy12
         BiEByCe6Xw9WqtEpDl6MUg72qw9UgfV7fKRoTvaOQodbQNkoDRWFGSiaOfhGpZQwM/GE
         pSZw==
X-Gm-Message-State: AOJu0Yyr36M3SMpVT+fe6w/C/uy7YKw5mk/LpBdahc4u+tvCWO14VSav
	pRpWfvXZmq9AA9LRxXUXYw/HI8XJQ1tfEEU7G6tGUjBmJCV3ZtGYUIUkXw==
X-Google-Smtp-Source: AGHT+IH4p+rKi+kxav0+gPINVDeE1ZlmfHcxiA+Uzx43uXFE9ExUtCRNWMsQM0fPxJHCrjbtk4ik9g==
X-Received: by 2002:a17:907:3f86:b0:a80:f6a9:c311 with SMTP id a640c23a62f3a-a8366460685mr226358266b.0.1723653936195;
        Wed, 14 Aug 2024 09:45:36 -0700 (PDT)
Received: from LOCLAP699.vf-sint-niklaas.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3f475ccsm196326166b.14.2024.08.14.09.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 09:45:35 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: ath10k@lists.infradead.org,
	James Prestwood <prestwoj@gmail.com>
Subject: [RFC 0/1] wifi: ath10k: improvement on key removal failure
Date: Wed, 14 Aug 2024 09:45:06 -0700
Message-Id: <20240814164507.996303-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is in regard to my earlier question [1]. After some testing with
adding an artificial 3 second delay between auth and assoc frames I
saw that the device would fail to roam 100% of the time. This further
backed up my theory that this firmware failure is causing some
timeout on the AP, and resulting it either ignoring the reassociation
or rejecting it.

Changing kernel behavior to fix a vendor quirk isn't great, but
in this situation since the key removal is non-fatal and it
improves general performance when the firmware does time out I
thought it was an acceptable compromise. I am also pursuing the
vendor to fix this, and allow a greater delay between auth and
assoc.

The reason I'm sending this as an RFC is that I have no idea about
other hardware, firmwares, etc, that use ath10k. I have only tested
on the QCA6174. Maybe different configurations _do_ need 3 seconds
to remove a key? Maybe this timeout needs to be a hw_param?

[1] https://lore.kernel.org/linux-wireless/9eafac85-2262-4f92-a70b-32109f65c05a@gmail.com/T/#t



James Prestwood (1):
  wifi: ath10k: reduce timeout for disabling a key

 drivers/net/wireless/ath/ath10k/mac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.34.1


