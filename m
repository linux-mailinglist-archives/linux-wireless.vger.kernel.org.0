Return-Path: <linux-wireless+bounces-21747-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B19A941DA
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Apr 2025 07:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F00323AC1DE
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Apr 2025 05:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9EC13BC3F;
	Sat, 19 Apr 2025 05:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLoSw71/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076BE184F;
	Sat, 19 Apr 2025 05:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745041813; cv=none; b=ruMcni121dddRTGfvs5oZ5Ou8tZwE3e85lSJaDZOffK88H4oCjwXzpg1CxB2L6kF//pkYBJtMM4WJDf/qZ2PXE9H5AF5EvCKaQCGRx16XdkIctXxIYFENdS0EJDOsJvuSuX+QicKAysmkEVr5RY8yLAhzEVFrb2ij7eqHESEXwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745041813; c=relaxed/simple;
	bh=LPli2z+7ZbrVnA9jRRA6A9C/NTHjoZymrzz2sqkkUSE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=F58vu/gorMNWoDzxBbU76/yog7ICQ+LWQuMNuhq+Biunldl3LwHVOjdDVq6QyqLAAAzpjRmlA3gBRfOgMt3WWtiak9qjXiESJsVV5NM1ZKfCwm7fn5hfLhAeZvYEdKdFaT9Ik8Zyp+iBJIELXq5miwET66yRJRUkwfbrPtTxb4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLoSw71/; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-224191d92e4so26746375ad.3;
        Fri, 18 Apr 2025 22:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745041811; x=1745646611; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPli2z+7ZbrVnA9jRRA6A9C/NTHjoZymrzz2sqkkUSE=;
        b=KLoSw71/BigBV1OgrZ6PmvyRbKTwRS/Wqo17QiknSaVHF8CkKUx9JJYpx8DwsxsSv8
         as1Ymj5a6oa+ZQnz4Kz/Ax/nBu7ceFykMwQUiZzsEmNQzVOuJwjm8wcU6p4A6AeNCG2Q
         YIaDtkXnTS9HKtVXLw6vQMtXKffCx9Q7+DF8GFw64nrl1XzN6obJopx/GWoHCvq/RFf5
         Bcbe0469zNbV45dGTP6TAz7eaxsXP6D3lFiEENtjjIqoxMpSvUj+4hJS9TudveSzQhjk
         7oF+rL1jvlT79XehB4RvCtf8fYT0XcPcxYzLw4zaIlfHuVoku/pRggEugOEU7gLqsnFC
         Eiow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745041811; x=1745646611;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LPli2z+7ZbrVnA9jRRA6A9C/NTHjoZymrzz2sqkkUSE=;
        b=lIUn+WY0dtZBUJm1SXQrOrg/+9MOGNdAi8Oxrf4LHl62ph7ZD9hFQHlua200IEnrRX
         xGfCO1JCpowqnG66YuTbAXSrOp0QgVgnvfObHNgH8GS8ezoCuJYeVV+xS0La5N0qS6c7
         cVUGC2EaN1BTe377AM+jaDmz2+g3quBkqMPT1rtlPa/03ffAgBacHlIkPnbqEHtmAEIg
         ek7pa1XzpNjmmHIAc7eE9LbbuqFlNIp467FM4ysoGXNDbs62qsHdAIjClfyH+L2Qavj1
         E0vmAdaBSH7IfHUgzWYY/TTo+7lS59jEnwQkoTM+aHhH6uBzTG2NmJQ0LAX3dEb26hfW
         g09A==
X-Forwarded-Encrypted: i=1; AJvYcCVYhmsilelXZuVT6psFsS1LJ6wsUPHYcIdW6uyNepp7PA9rM2aC0R64LgG+VjNHE10NIup1cKeahn0Y+jM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4nDSvzczldp0uXBpgLVSBhaz7Z+sQgcYzP1MpYRkRM1btSZYB
	RIyIfahTUKVZFgi7lKJhG05TCaECngAyu+IPKxXnwKdR6st3buKl+1A6qA==
X-Gm-Gg: ASbGncsQgr8ZCRaS6nU46oKjXmfb0okvDfZRkyJmzD9KENgYCQqLV8Lq/Qnnf069n/A
	Ahj2EczTa1ljE5ppAjy+nLv2337FnfDobuTRe8oVBR5l/U+K2eyCxCvF7p1j0ehBFcOUsf2jN1k
	9yjDFTI1GvnrsiXain+NZR09h9zp8jJe5xVvmUR8r9zj09bCEwDAB0yBjmRU2tAD43ttoI5OIAD
	63J5FUVf55W4qGScB/5hwNik0+xUQoN2FxpWKI/2xqRwNML409k+4Gc9heYIfbIEwQ6KxVrTgO3
	mYLCTgpkrWaohH2+3YrXts9xd0EVsXxYEw==
X-Google-Smtp-Source: AGHT+IGQZchKTdoSpm+MEW5tGCs7WYiTxb66sZhCT65AdH09WlgfjP7ijO48WNYCDTzZv7XgiDF0GA==
X-Received: by 2002:a17:903:40cc:b0:216:6901:d588 with SMTP id d9443c01a7336-22c53580c88mr77144905ad.15.1745041811265;
        Fri, 18 Apr 2025 22:50:11 -0700 (PDT)
Received: from localhost ([181.91.133.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bdafffsm26599525ad.49.2025.04.18.22.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 22:50:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 19 Apr 2025 02:50:08 -0300
Message-Id: <D9ADOZOBNY7Q.1MNGEH9AG470H@gmail.com>
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Kurt Borja" <kuurtb@gmail.com>, "Miri Korenblit"
 <miriam.rachel.korenblit@intel.com>, "Johannes Berg"
 <johannes.berg@intel.com>, "Emmanuel Grumbach"
 <emmanuel.grumbach@intel.com>
Cc: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Todd
 Brandt" <todd.e.brandt@intel.com>
Subject: Re: [PATCH v2] wifi: iwlwifi: pcie: Fix match condition in
 iwl_pci_find_dev_info()
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250418-probe-fix-v2-1-ec1ef2d8a534@gmail.com>
In-Reply-To: <20250418-probe-fix-v2-1-ec1ef2d8a534@gmail.com>

On Fri Apr 18, 2025 at 3:29 AM -03, Kurt Borja wrote:
> Fix the following regression:
>
> iwlwifi: No config found for PCI dev 2725/1674, rev=3D0x420, rfid=3D0x10d=
000
> iwlwifi 0000:3b:00.0: probe with driver iwlwifi failed with error -22
>
> Which happens due to an extra `!` when matching `dev_info` while
> probing.
>
> Fixes: 75a3313f52b7 ("wifi: iwlwifi: make no_160 more generic")
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>

Tested in a recent bug report thread [1]:

Tested-by: Todd Brandt <todd.e.brandt@intel.com>

[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D220029

--=20
 ~ Kurt

