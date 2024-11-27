Return-Path: <linux-wireless+bounces-15761-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 885689DA9EA
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 15:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D602281C55
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 14:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76251FF612;
	Wed, 27 Nov 2024 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqbUWomu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BA91FCD1E;
	Wed, 27 Nov 2024 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732718155; cv=none; b=NAp5ObA6gp0dQe0fxtRJKc7PqyL8VC5HH0pxYR0KWBqJgBfNLmwlkKBIYh2syZrODnbvXklHDzwyHCx7SkBPy5CKGq5hRfZBonAaPl16LQEqIuGr11YiR7Qgb/85qaOi2xRetmsZBOHAp8PKvhA6JjrNyL/KldDhu0obumFOXMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732718155; c=relaxed/simple;
	bh=oVpqtsNfjE7LBjv/M5++nxEBd8xss6xBkvmobOr5VfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RzMQSVFFMrFbo6QIQCH9UoHsw0PsUCtpNn/LkROVM2p/nKwwSg4zOo7v0SA5TACCMNBhF/syYx+/pusjwrZuSuLj+NyKvVZWhN8p2MNmIzNUwixpKkCQje7jzSGRowaycowLyqDtZfMv/PhEfaGZMt9lRIJJoeRLNaxs21/Wcdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqbUWomu; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21200c749bfso67577825ad.1;
        Wed, 27 Nov 2024 06:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732718154; x=1733322954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdBKYu59zz5dNnmAPo9hi/5rPJBTreSNmfq7NUIW5R0=;
        b=PqbUWomuwwIhabfFO9U581LJFeQ+Oz4oYEqEMgbCyHZYER9nDRSR7uu0qOetzypZEv
         LhoY7w+dlaVx368jnQ98BTUApAGhQIMmVPAD8zU4ahzsd8pKXlm8pq5ohX8KLErx5r8P
         S8LQIwdwlcwFIl49ZIoWYtvppO54z6vcK1iodUAbd3uUwMNwTf5PF7Ez9rqUxWyzAmGN
         OGOZMu2pOMZzImTnUeMueYDehSX4Ax0JP9Cs8Mdh1jarVxCC3euSBL7R3l3HhK/ZX7O5
         BHbljQtBFPBjwhlOdqM59KHRK3WGjLF6hYkXhoiGUqoDgdbzg4/3m97UkeoJTr0J3gpW
         z+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732718154; x=1733322954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZdBKYu59zz5dNnmAPo9hi/5rPJBTreSNmfq7NUIW5R0=;
        b=wis1eKHh7N4PGiKBDhr0YmWNWGA8Bc4OQ1Y0L2SShgu4EczElp5SX/8tkE/x4cgGJf
         AGbdFIW+lvrSFj6NTREgFm2FvHbyn8JF+GuhVvK+9GzLjhsWiogUWWT+P43Rxm7kdFhm
         rZh+YxIKi+XSA4/E89K5EP52C0jd2kjBYwZ13qIs+4rnw/Nghdsvefk1n7kYDvDp1xsI
         qGV9Cai0QYYmpTRyM/ZUpzlztUTDtEKTe9fRW2pVJ0Vf6X/t3S/Wpm8E9GbSPl3FWpa4
         3MsQRI4V5Iq2QQKmeWcHVkTeAGmoUfUaHe3JQGCbuvvj3mQhCTn+45pI7FSImRkcCilT
         T2mA==
X-Forwarded-Encrypted: i=1; AJvYcCUgHe3jp7BQZuLT4l3WpTQouKQFsiczmT7ogJirR9tbyvAOoZbcf7x7353G9wXhqzn8Qg9MmJBtZjOD6S0=@vger.kernel.org, AJvYcCWGLZUkBF+0Ft0VazO+UonM2LvL+p8F+E7gbxeEUwIJFuJ46N0eKBJPJyJ/PW0erebIXsAv+wtCNLn/dSnQQsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbgL4n2XYx06324yAj5EmpsTy8PPA4eUsdgjiX2Pzfrp41Z1pJ
	98O/PRbdKhHUjPyse3YnpSmCK0A+rl/efOJbnZLwxHjug0weFH6f
X-Gm-Gg: ASbGncvZ+HFNpCU+ANUysbzSym865wCytDPNw9Kbb3SenkZctDUwtjt6xk7nDg7Lnyw
	r+fb7Eg17KMAu6d6w6ZJeiZ7COEQH2DQSgCR3CoiqJNApldFGE4tZTsCK/dAUwzBjeDNTd6vIY2
	oMO6whztH1XBU85QyaNDK9t2XAQAG54oC5k4nJts6YCK9Lp1kSARgHIDNHXd2YxMuo4InPSo7oZ
	eEE6tUGw8G8z/w5Zdj1hyNy/+A7raO66Ojj8rs8kPAprrtRn3MORtu5odY=
X-Google-Smtp-Source: AGHT+IGHyfCyr8T1DrDbozg4fFTa7y3qsmhyeH71De1a2eJmZ1ljjREFI3OAKgjsu9qkdKeyCPsGcA==
X-Received: by 2002:a17:902:e881:b0:20c:c086:4998 with SMTP id d9443c01a7336-21501f622a5mr27261175ad.55.1732718153136;
        Wed, 27 Nov 2024 06:35:53 -0800 (PST)
Received: from localhost.localdomain ([223.72.121.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215150adb5asm5101175ad.258.2024.11.27.06.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 06:35:52 -0800 (PST)
From: Baichuan Qi <zghbqbc@gmail.com>
To: markus.elfring@web.de
Cc: ath11k@lists.infradead.org,
	jjohnson@kernel.org,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	zghbqbc@gmail.com
Subject: Re: Re: wifi: ath11k: Fix NULL pointer check in ath11k_ce_rx_post_pipe() ERROR code
Date: Wed, 27 Nov 2024 22:35:06 +0800
Message-Id: <20241127143506.28267-1-zghbqbc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <30b208e0-55a2-400f-9638-1765e7ed3bfa@web.de>
References: <30b208e0-55a2-400f-9638-1765e7ed3bfa@web.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

thanks for your reply

> May the detection of a null pointer for the data structure members
> “dest_ring” or “status_ring” really be interpreted as a successful execution
> of the function “ath11k_ce_rx_post_pipe”?

i submit this patch just want to ensure the last codes after
`if(...)` in `ath11k_ce_rx_post_pipe` can be successfully executed.

There is no error handling for NULL dest_ring (or status_ring)
in other funtions calling `ath11k_ce_rx_post_pipe()`, because it 
would return 0, like successful end.

I think this patch can not change so many codes in other functions in
ce. This may involve a lot of error handling operations,
and depending on the severity of situation, the driver may even
re_setup the ring.

I will submit a v5 patch, and in that patch an error code will be
returned.

Baichuan Qi

