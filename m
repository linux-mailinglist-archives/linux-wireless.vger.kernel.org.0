Return-Path: <linux-wireless+bounces-11129-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CEA94BF7C
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 16:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B10F7B27A74
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 14:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE092190041;
	Thu,  8 Aug 2024 14:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwBq5aTZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E0618FDDD
	for <linux-wireless@vger.kernel.org>; Thu,  8 Aug 2024 14:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126471; cv=none; b=ixNJaIp/lffxLJ2pGX/bRpzlda1itIOQUVIqnCIcpBkjXI7aPVPMH6zT1n5Z407zF4Q1IhejhHK/25Eczhlp5a/ZVOyKGwEj1nfvsXhPdV242LlMCJWauNo2coIOxCCncwX6jKpO7R495/6cI7G4V3PkaNbJzwjPXpyfcF2QD2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126471; c=relaxed/simple;
	bh=l3YbQr8TU2dVF9APbANAgM3VgZWmjXBhgWuticPkQa4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=trFym21giqA8TZKFC1kxCEE7iNfkdTAxx3PL1KGJ/K2MJImgP/l8WjTUvfxmS9T1EWkHDisOIH3hU9+wVj0kEGrlHlCv/DmJtq5GLZ758HgUh4RiXsiQGgh2OStyV1iBtFJW9vzPUnxXSuk7w/0MC5xoiVp5QZAMxbXgg3nYmfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwBq5aTZ; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e0e6cbec8caso945914276.1
        for <linux-wireless@vger.kernel.org>; Thu, 08 Aug 2024 07:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723126469; x=1723731269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bIecfrWZkZyY7vi/pXdM7VqV1s2mH5g14gt/H13iYdA=;
        b=HwBq5aTZPoM+A5XVIRb3fdDxYv2RfTrMrJQf0biDW5iSIGV9j3tOsQtfWPbNJBpiWr
         cxxERviEEGPMaKrUdBctyujbweNBzYt1XTzjhLkWGzf8Oba1k0bxfPZQCjIyp6Hunj0D
         bep8cQfdAcz19lHX/RZg+NQOxtea33TexgVV6+DB20bugTqXY8KVZ1vgs3jVh3BfcIUY
         GljARYVIf+akbAoKcc+sA281F+d1can23ZWimCXxUfc3FtTqmyS3Xb5jVv7PmJFo2iPT
         D/oBtxX8QWgqqq6iUeiDrbONyVrtenopzh098v/7jYpdw1ypFHz2KlB4bELl7xKVNjoJ
         OrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723126469; x=1723731269;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bIecfrWZkZyY7vi/pXdM7VqV1s2mH5g14gt/H13iYdA=;
        b=ufNNy6Qyz9fCBf73LIrs870Q5xY92PnOGGEd6ZcSsJ7mAHcl+BLK0x3/NUNvcLOK+F
         ob/5xOc75i7Sp18pdKrlkiDSmRxlIyw+OzDPVJYFa6kN+QSd2UaeKa4ZOelIdTst+xnP
         tm3p7L2HZyAoYB0oYDFJVTI9CD3koprftqfAC7+d0eNap/Kbe7ldah9ZIZWPHeULVW1y
         IA3PIlFexbaHcGDWkz9zQsxDfll3xOynMyUbHgpxuvLgulSXSpv6Fq76iePb515QkA2z
         pyqQmDUelAaauLqYjcTA0Li3WCvC0rJzG19HsB9LPvt+gMTsuab12CoyOqDwpPmzc2tx
         Lzag==
X-Gm-Message-State: AOJu0Yxuucoutkqrzd/z643/wQEtgEcBhbE2+w72AX9NRGi9u9K8c/L5
	H36aNBWMcYFm4OiwzLuucCaNqwgAzH/2upzCV8nout7SwnqFp9ZysRBU+KAB3oyGjWYlDcNFIR1
	HYcDjZlyqGRjCXy4r0Xth6LyQQvWrFjvL
X-Google-Smtp-Source: AGHT+IG6tj0uiJyNAg7xWe86dKnj16gD2BvW5pkMRBiFMiliLt2OVc1ZPal2MW+3zOJOt/1iODVD6T+UWeR+ffE/HzY=
X-Received: by 2002:a05:6902:2405:b0:de5:5693:4e96 with SMTP id
 3f1490d57ef6-e0e9db18d98mr2110223276.27.1723126469214; Thu, 08 Aug 2024
 07:14:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chris Bainbridge <chris.bainbridge@gmail.com>
Date: Thu, 8 Aug 2024 15:14:18 +0100
Message-ID: <CAP-bSRbkgPFujacnLzO79=C=hF59E6JwKBkxcRL2RpZ225EHKA@mail.gmail.com>
Subject: iwlwifi: WRT: Invalid buffer destination
To: benjamin.berg@intel.com, miriam.rachel.korenblit@intel.com, 
	lenb@kernel.org
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

[   16.768409] iwlwifi 0000:01:00.0: WRT: Invalid buffer destination
[   22.545080] iwlwifi 0000:01:00.0: WRT: Invalid buffer destination
[   22.892104] iwlwifi 0000:01:00.0: WRT: Invalid buffer destination

This error happens on every boot. It was reported by Len Brown back in
November, but is still present in v6.11-rc2. In that exchange,
Benjamin said "quite likely it should just be hidden unless the
IWL_DL_FW debug flag is set (i.e. use IWL_DEBUG_FW)".

The cause of the error appears to be a firmware regression rather than
a kernel regression. It does not happen with
iwlwifi-ty-a0-gf-a0-73.ucode but does happen with
iwlwifi-ty-a0-gf-a0-74.ucode onwards. (I found these details in the
Debian bug report and have verified that this is accurate using a v6.5
kernel).

There are many bug reports for this error elsewhere (Debian,
ClearLinux, etc.). Is it an actual error? Or just an erroneous message
that should be hidden?

