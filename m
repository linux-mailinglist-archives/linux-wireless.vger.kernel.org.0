Return-Path: <linux-wireless+bounces-12003-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC0695F967
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 21:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12598281A9E
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 19:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC3C198838;
	Mon, 26 Aug 2024 19:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="WBeu0PI7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9B3135A79
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 19:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724699226; cv=none; b=eFSyl4Ht60DqUZJxDt/P9+wXLCJv+3KIXSjO7zSqMMVRM+iKsWAO5Vi4BXOHbUdWXiTmZr4PemnevW41hdiWt9mQ4ZE7zb2dFdq5NLh0WQ6VhpauN98iHTZYbWqAUuf+pAcSE4qBOjgVzxF2Qjcs8Ao9Q3bV8E4y8hmmyj7K38I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724699226; c=relaxed/simple;
	bh=mLnY6xOzwWaesQTmifViuTF+TizIOT5Q1ouJo1E5ojY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mt8W+MJZS1yh5sLSdNOul2AHPCvXdTyxRt7BEVRTqNLwdw4D0m/XP62DLtoNBtlJL1T6Pq9LFhYIxvFVwd/jgngbYXqSRl8JW1dE7hrtovYYMuOM59JDyFk50F+dt57Ps/Ug7o4y0QUEOapRQwKZ0apF+Zguu0XYNaUnRXHrhGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=WBeu0PI7; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a4df9dc885so290870785a.0
        for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 12:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1724699222; x=1725304022; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gDdLZa8prVF6p7lP81gEYSCjTaypmgSa77jgkV1uK9s=;
        b=WBeu0PI78VpitnhUbvc6jhphQfeNx7WoWnnrzhxvjUS+PxRL6buQZ4Sm+V7ghktItV
         4CceZ10z5eZFyuRW4hdrem7GivCzOpkGtbLe4aOYzACQFj1RxDSnrHIoI/DBbX7PdvGc
         FEamiHKZRoA8NLQe3cJfScrHkWM8Y3RtZIdLaPyNoCw1WBXbjVjvtAtUklB1U3GH+6Yf
         7mRjBa/AMd9Vnt7KhmlkgAKwBxegLMgZXVaovuAUWt525QQtZLUlJLbgq20kNX6dJWu6
         x8ZBdK7Hdpot0qP7LTAY/UYz+tn1DoGCWFl4rLbG1y+hHEQSr7yUVnuRQkmxdBW/Hyq8
         Uocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724699222; x=1725304022;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gDdLZa8prVF6p7lP81gEYSCjTaypmgSa77jgkV1uK9s=;
        b=oztTr78VcXsGg6Kbf0UAYyxlmoPl5is6Ya8ZcZErANhSde83MBz0OA2RmTplN6WX2C
         zJx68Ynn64shZGIiW29yGmP60zrj8KhPsWfTEGGnqTFhPUVIEy6k7rpaUx0g36UFoKiB
         IfybVzQDRK+xS/liEe2O5GCNM0kjg2bhrU0ayQrBlNn3uGrz2mKdz4gjRJqxi7c/X7K4
         ZHXnK0e9GpbndpZ1N/kawZHXo5LLqQbbtbdSKgc2gwibbpAALrTZ692WWXOIO7OFIxxi
         cO0B6Q/HWKI7TkyRVW4Cb6p7bmtSJXb2QPMTOFOShYi/CRPmERfkqKie5MqlDP7g8EbX
         kdQg==
X-Gm-Message-State: AOJu0Yyor8UUj8xV8JFgwHZO9FDOLhpygMff3LvZycU5UxrscpMflpUQ
	9UiuS9XbGLG7v2Qx/30gulKm1dYJzJ9IzMCL2Eoq8GXgwS0YjPNlbiGUdBRfnLu/LibhsxC6Cpn
	Mvw==
X-Google-Smtp-Source: AGHT+IG626v4mTOtkEqnwdbiOOcerFECOHnSzR4Ch5SOi4Ox3ykyi9cvCBsrTxe1MlgsofjV9igryw==
X-Received: by 2002:a05:620a:178b:b0:79d:7893:1cc with SMTP id af79cd13be357-7a7e4c4bc24mr86065785a.12.1724699222047;
        Mon, 26 Aug 2024 12:07:02 -0700 (PDT)
Received: from rowland.harvard.edu (nat-65-112-8-18.harvard-secure.wrls.harvard.edu. [65.112.8.18])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3cf6cbsm481039885a.83.2024.08.26.12.07.01
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 12:07:01 -0700 (PDT)
Date: Mon, 26 Aug 2024 15:06:59 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: linux-wireless@vger.kernel.org
Subject: WiFi constantly changes association
Message-ID: <eb86cf20-2b1b-4871-82a4-441ba81752dc@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The WiFi interface on my laptop is constantly (i.e., every 5 - 10 
minutes or so) changing access point association.  Some of the time 
there is an actual error code in the log (although I don't understand 
it), but not always.  This occurs in a totally static situation: The 
laptop is sitting still on a desk and the access points aren't moving or 
changing.

Can someone help me to find out why this is happening and how I can stop 
it?  Each time a re-assocation occurs, the network connections stop for 
a few seconds.  This can be very annoying when it occurs in the middle 
of a video conference.

Here is a sample extract from the dmesg log:

[ 5924.412721] wlan0: disconnect from AP 48:b4:c3:81:b1:a0 for new auth to 48:b4:c3:81:b7:d3
[ 5924.464823] wlan0: authenticate with 48:b4:c3:81:b7:d3 (local address=3e:de:7e:33:e6:22)
[ 5924.465609] wlan0: send auth to 48:b4:c3:81:b7:d3 (try 1/3)
[ 5924.476258] wlan0: authenticated
[ 5924.476740] wlan0: associate with 48:b4:c3:81:b7:d3 (try 1/3)
[ 5924.485408] wlan0: RX ReassocResp from 48:b4:c3:81:b7:d3 (capab=0x11 status=0 aid=16)
[ 5924.489408] wlan0: associated
[ 5924.489745] wlan0: deauthenticating from 48:b4:c3:81:b7:d3 by local choice (Reason: 13=INVALID_IE)
[ 5926.459344] wlan0: authenticate with 48:b4:c3:81:b1:a0 (local address=3e:de:7e:33:e6:22)
[ 5926.460183] wlan0: send auth to 48:b4:c3:81:b1:a0 (try 1/3)
[ 5926.465654] wlan0: authenticated
[ 5926.466701] wlan0: associate with 48:b4:c3:81:b1:a0 (try 1/3)
[ 5926.474615] wlan0: RX AssocResp from 48:b4:c3:81:b1:a0 (capab=0x111 status=0 aid=16)
[ 5926.478361] wlan0: associated
[ 6007.455887] wlan0: deauthenticating from 48:b4:c3:81:b1:a0 by local choice (Reason: 2=PREV_AUTH_NOT_VALID)
[ 6008.413727] wlan0: authenticate with 48:b4:c3:81:b8:03 (local address=3e:de:7e:33:e6:22)
[ 6008.414588] wlan0: send auth to 48:b4:c3:81:b8:03 (try 1/3)
[ 6008.423586] wlan0: authenticated
[ 6008.425652] wlan0: associate with 48:b4:c3:81:b8:03 (try 1/3)
[ 6008.435906] wlan0: RX AssocResp from 48:b4:c3:81:b8:03 (capab=0x111 status=0 aid=18)
[ 6008.439903] wlan0: associated
[ 6042.021133] wlan0: disconnect from AP 48:b4:c3:81:b8:03 for new auth to 48:b4:c3:81:b1:a0
[ 6042.106585] wlan0: authenticate with 48:b4:c3:81:b1:a0 (local address=3e:de:7e:33:e6:22)
[ 6042.107509] wlan0: send auth to 48:b4:c3:81:b1:a0 (try 1/3)
[ 6042.115457] wlan0: authenticated
[ 6042.116068] wlan0: associate with 48:b4:c3:81:b1:a0 (try 1/3)
[ 6042.125980] wlan0: RX ReassocResp from 48:b4:c3:81:b1:a0 (capab=0x11 status=0 aid=16)
[ 6042.130435] wlan0: associated
[ 6042.131232] wlan0: deauthenticating from 48:b4:c3:81:b1:a0 by local choice (Reason: 13=INVALID_IE)
[ 6042.138005] iwlwifi 0000:72:00.0: Unhandled alg: 0x707
[ 6045.236581] wlan0: authenticate with 48:b4:c3:81:b8:03 (local address=3e:de:7e:33:e6:22)
[ 6045.237429] wlan0: send auth to 48:b4:c3:81:b8:03 (try 1/3)
[ 6045.239528] wlan0: authenticated
[ 6045.240097] wlan0: associate with 48:b4:c3:81:b8:03 (try 1/3)
[ 6045.244380] iwlwifi 0000:72:00.0: Unhandled alg: 0x707
[ 6045.245552] wlan0: RX AssocResp from 48:b4:c3:81:b8:03 (capab=0x1 status=30 aid=0)
[ 6045.245574] wlan0: 48:b4:c3:81:b8:03 rejected association temporarily; comeback duration 4882 TU (4999 ms)
[ 6050.242115] wlan0: aborting association with 48:b4:c3:81:b8:03 by local choice (Reason: 3=DEAUTH_LEAVING)
[ 6051.552052] wlan0: authenticate with 48:b4:c3:81:b7:b3 (local address=3e:de:7e:33:e6:22)
[ 6051.552888] wlan0: send auth to 48:b4:c3:81:b7:b3 (try 1/3)
[ 6051.558910] wlan0: authenticated
[ 6051.561162] wlan0: associate with 48:b4:c3:81:b7:b3 (try 1/3)
[ 6051.568711] wlan0: RX AssocResp from 48:b4:c3:81:b7:b3 (capab=0x1111 status=0 aid=3)
[ 6051.572783] wlan0: associated
[ 6051.645974] wlan0: Limiting TX power to 36 (36 - 0) dBm as advertised by 48:b4:c3:81:b7:b3
[ 6257.740072] wlan0: deauthenticating from 48:b4:c3:81:b7:b3 by local choice (Reason: 2=PREV_AUTH_NOT_VALID)
[ 6258.495979] wlan0: authenticate with 48:b4:c3:81:b1:a0 (local address=3e:de:7e:33:e6:22)
[ 6258.496970] wlan0: send auth to 48:b4:c3:81:b1:a0 (try 1/3)
[ 6258.506457] wlan0: authenticated
[ 6258.508568] wlan0: associate with 48:b4:c3:81:b1:a0 (try 1/3)
[ 6258.516662] wlan0: RX AssocResp from 48:b4:c3:81:b1:a0 (capab=0x111 status=0 aid=16)
[ 6258.520362] wlan0: associated

Is there any way to debug those INVALID_TE and PREV_AUTH_NOT_VALID errors?

Thanks,

Alan Stern

