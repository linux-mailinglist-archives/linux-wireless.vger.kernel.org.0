Return-Path: <linux-wireless+bounces-4792-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 851E087CF62
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Mar 2024 15:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABE231C2097F
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Mar 2024 14:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C1239AF0;
	Fri, 15 Mar 2024 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vxe/PlJ3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E953EA6C
	for <linux-wireless@vger.kernel.org>; Fri, 15 Mar 2024 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710513972; cv=none; b=aUktFuIyL5F2TM8YjLp2ioS2wBtSeRBzfdAvwAJqUUE0EC/JZHPfnXKoUpNPpLjrchXpQb3cbtcjIwMUzWtakPg9osq2p0yDbSKDMY+R3QxaC1cw9xg/dyfiOakkQ2LR3xphKFFPmTisI2e8Sh59ZHauKXzcNXo/XLbWmWBSVmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710513972; c=relaxed/simple;
	bh=DcMrcdn2vuRcwVQdOaeQyrYoWW7C+H+hS5KsF0jddsI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jbLxBErH3PlRIHm0CSAN/DEAi1mD6HVFl3wkCun1pSDO5Cx2QZj6th35hvEeUzV4vJNY8hlR8KJQ8Tj/UUBQVSzfVT5FQiSifWPwbHXuWiytYDdU60TelWJIozXXG434DfEDbs1b347gbOS0uwqIePUS+zgRVgyLwRSrJlFVFW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vxe/PlJ3; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-568a4e4893aso2480482a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 15 Mar 2024 07:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710513969; x=1711118769; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/2XU3X3FBDzCsadNkw+qwLEfun6VJ47bHY0dcAfdGGg=;
        b=Vxe/PlJ3Fau4ycfLOnSvN7qI6IMUQQDjn8Moz2F8y9Wt6izGVq8TILMSYc9j0sZRwA
         d5HwnXY2tm7yBVXglQQAwdK0hfDz9OoQBM/fqsmu0f1HYP9WPShjVoLUqeCs5NHl5Nbq
         jxa8zsN834rXSBv+/zKwdW9CbIU8IXNTph+bG8tKXz8dadYxMEl/Rb6GRJTeWMgJsVfa
         R324spv1xwFAhTpIMWolN0RLmuZfsqLMUFVYeJKNEncigPVBF6MYKxd1gUgKP2jiVnJJ
         9w9+R1QG1hllHBmKbdpPmgXmRcNiDNOYqirDqKPoctiwmwh15bumUXJGMmd8873qSWuy
         3cFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710513969; x=1711118769;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/2XU3X3FBDzCsadNkw+qwLEfun6VJ47bHY0dcAfdGGg=;
        b=XZ37IZY/BOm2TfWLeNGrzQynpeyag0AfBYU6FgPekKopQXokjV5bPlYMRESSRrK2li
         upawa21Cwy1StSK8HVil9qRJg4FAusnlOeFPndm0O0FGb1Z/HnAQYFsKwbF7Ok/DzzKU
         Sjhj7YU6Ig2n5jp6UROS27oPYlIHeCKwYHOhpeMdr7BJT8Job2Vi+nJ9oqA/m89MdI/5
         mGmDra8q6+wEfrnIxfrcJII9KumEYYwFaTIRdhxz6PxWAtcJER+/vYAgdfBOfcdfYgqb
         OCpRul9vyUWLEHHf4nt2Lf2eAJ9C5IhbpPU5vSfZQU+LZKhPZWp5zahqytzJ0LldlseG
         yCYA==
X-Gm-Message-State: AOJu0Yza3yTvTGpIF3SDAzo9pxy94gc2X+fWvxcaCt1Il8sBj3Kq2Q7C
	BE5h/6/7jLECue8u5YRxDXSmK4nQAs5NYZmRM+q/6XkHXcex0WtYGd9m2k7oUwq4IFZiCWhP19w
	SDe4RqTCXAvc1xlRLSaZ8PE0KTtSqGAnUvQM=
X-Google-Smtp-Source: AGHT+IG2MgCCTZV4i7/iF8ElhIOdprz6NcCkXFf3a5xXOE7Ll+hoiK0Fv6b9G4zDoodpq02f+FQAjPdkvQ17EuUpAbk=
X-Received: by 2002:aa7:c38b:0:b0:568:90b5:3295 with SMTP id
 k11-20020aa7c38b000000b0056890b53295mr5919014edq.7.1710513968837; Fri, 15 Mar
 2024 07:46:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
Date: Fri, 15 Mar 2024 15:45:57 +0100
Message-ID: <CAFED-j=3_xLuJFp5R_gThMtv2C6r6WzRxzrY3_wjFTn=XJQLwg@mail.gmail.com>
Subject: BE200 - 6.5 backports - disabled EHT issue
To: linux-wireless <linux-wireless@vger.kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"

Hello,
Using EHT AP with 320MHz support - 6GHz.
Seems this part disable EHT on BE200 during assoc.
FW used: iwlwifi-gl-c0-fm-c0-83.ucode

I see this one do this:
 if (!ieee80211_verify_sta_eht_mcs_support(sdata, sband, eht_oper))
      *conn_flags |= IEEE80211_CONN_DISABLE_EHT;

Testing on openwrt and using backports.
Is there some patch I can easy cherry-pick to fix it?
So far just disable ieee80211_verify_sta_eht_mcs_support() check and
BE200 works in EHT mode correctly.

BR
Janusz

