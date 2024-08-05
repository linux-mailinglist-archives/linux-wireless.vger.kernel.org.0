Return-Path: <linux-wireless+bounces-10964-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4292F94817C
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 20:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07F01F21059
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 18:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF8D156F42;
	Mon,  5 Aug 2024 18:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HW/aLg8B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4B7143C69
	for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2024 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722881839; cv=none; b=SyaVznRfEN7fTs1IzVBGZUywqwNe0MD3YryhTMCqe6/Yvgcm6DKQIzQ7Ozv/qL378DD41cWyn7wznpHK4Utyouxwiiy/cc2erglTvMcudyiyesJ6PVTBue5dp/d8L0EM9fVl9Og+nWXttEwUpf24K67sYrsfCRcwzii4LW3vU3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722881839; c=relaxed/simple;
	bh=D8+tT1xSLpaf1vdLABOn8y9yvyIbsxyREjoyMgwFKm0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=LM9vOD1pS3X4GHiW731ZGuZk57Ta3ft2JkuxcFoC84f4m92j3N7F+ZHMRn2Xz/1Nx2uEGzUS7tN/yUuuXQyIaCZvkdYY/wfd/5XpkOXdQJbkiGf9VwgU2LqvMenGhZ1BJHubTt+ORX6IGJ8ax/6FVnN4Wdbn8AbHvGa8X6j8CdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HW/aLg8B; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d2b921cdfso9605372b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 05 Aug 2024 11:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722881837; x=1723486637; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHYJLOblerfTESYd1f7gtqU72eY7daGBvO9xKa/hYSY=;
        b=HW/aLg8Bq4XidlNZSwj68WCwQsXORSGcq9jQgZI/j5b1sYxISXve2NQX5ew8Z/r62b
         dvltiRMjh3kZ8EZZl1gDdmyiU+8r8p1Zxm2N4Fe0rtqNrjnrib3fnTHG0UomhaEF0dz+
         LyzVDi954M2vGA/zgJXziJaPxhG3WVzXdVSJHg/BmbGRMpL5Of7TUpZLEDJayhzuwnAb
         ooDJr9hUJSO9le3j++MBkQBGq2AsX4zAaFb0B/AY88X8PkyErtYELepnI+alqL0Dl4KU
         yQgN91QCSPOgnXQCMFe3aYuDhZtCv4i8u08XgRP7kTgkkYCKPpysZiPl+Q3NxKJevdfT
         QMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722881837; x=1723486637;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HHYJLOblerfTESYd1f7gtqU72eY7daGBvO9xKa/hYSY=;
        b=wKW7gl34OkJzXAOIV1jauZ7lmO18pfLNH+k8wqxqpD88Q3UnPMrZp4ccCbzS8X2Szp
         DfpapOl54W/SebEiP6HPlPsuLUSQed1S7q+HPCNmljmyQWU0pg71yKW3GTC4sRqcrmSb
         LFLMP/O/xBEIVKF66Z8IiwA3FkfXi2aonN0L2/+yQH04OotWGav/4MzZPBnHUX2TYsAR
         URH+OL9TH29m5Fuw+DiFtqATf0twV4dAy7bceSxMH6VmGOdxlFkBdkPHcQxV4kvNuny0
         j+0mEX/PmOa+PBNuEpY1hk3zc51O8wNtraMFNkJLA7DHcEalLqoiMHTjX+PuQddEd+ML
         D5bA==
X-Gm-Message-State: AOJu0Yw4W43UJ6bR7amERMEXdtWS33sn73uM40YXvfG+igM1twNoP8fe
	Gv4q8UyTrG+ntkVDcFXFztHszYsMYF8B6OSOsGv1ZH3wd5sxKGkOC7qwMg==
X-Google-Smtp-Source: AGHT+IGjK5ooJ8zst3ebgeb2sW6OukNwIC2IbDXIIP0mLmm6/uF5yWVSunV3IjIAl5O2BbBLNpKSzg==
X-Received: by 2002:a05:6a00:4b04:b0:706:6b4e:64c7 with SMTP id d2e1a72fcca58-7106cf9cf2dmr14966222b3a.9.1722881836644;
        Mon, 05 Aug 2024 11:17:16 -0700 (PDT)
Received: from [172.16.40.166] ([103.78.35.70])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec439f1sm5691803b3a.78.2024.08.05.11.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 11:17:16 -0700 (PDT)
Message-ID: <45213523-32f6-4e82-958b-6271e8b7e366@gmail.com>
Date: Tue, 6 Aug 2024 02:17:12 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nathaniel Chin <thegamingorangutans@gmail.com>
Subject: wireless-regdb: Inaccurate regulatory rules for Brunei (BN)
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org
Content-Language: en-GB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I've noticed that the current values in the regdb for Brunei do not 
match with the Brunei Darussalam Radio Spectrum Plan (2014-2015 version) 
<https://www.aiti.gov.bn/media/voqau1jw/brunei-darussalam-radio-spectrum-plan-2014-2015.pdf> 
and the Telecommunications (Exemption from Sections 33,34(1)(b) and 35) 
Notification, 2018 
<https://www.agc.gov.bn/AGC%20Images/LAWS/Gazette_PDF/2018/S039.pdf>.

Which both state that the authorised bands are: 2.4000 - 2.4835 GHz at a 
max of 200 mW; 5.150-5.350 GHz at a max of 1000 mW (2018 document); and 
5.725 - 5.850 GHz at a max of 1000/4000 mW (with the latter requiring a 
license).

Additionally the 2015 document refers to FCC and ETSI regulations and I 
don't see any mention of Japanese regulations?

Best regards,
Nathaniel Chin

P.S I've had to resend this email because initially it was sent as HTML 
instead of plain text so if you've received two copies: sorry.

