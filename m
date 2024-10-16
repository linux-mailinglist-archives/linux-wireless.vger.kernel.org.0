Return-Path: <linux-wireless+bounces-14107-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B84A9A142C
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 22:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DCE21C223DF
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 20:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDC5216A05;
	Wed, 16 Oct 2024 20:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="AM57Dk1k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9219D215F5B
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 20:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729111209; cv=none; b=C8rTQjrEezgRz6lrPDs3nwV05y0YX5mCXwgjAJrZVOfJ1BImwTjMiE2/tBd9yC6gwLqnEzrESFx7EQkWHvSfWuG7lZ0d6UzEuU9KY/TsIoRN7Kdy82feNOPL5zv8gyrFoGmijxk1xFYs+giTGoMBxZvK+KLIgWYEM2VA4dcRZyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729111209; c=relaxed/simple;
	bh=+ZhmjY733F1gROFYepfH+/BCr+cGlFRNdGmMnzv/Ph8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=YJ3kv/fqr6HzZBH9TY2MWF0Cw49ZvliTzQ+eTA9/hWyeSTuiUUuPS7Wd3xWRA1ewMpuCRYHHmRTcCp/1qhny6uLePR7dxWg4Ab5tTQf/HgXU6jL723FJj96r91FIpYrz14WIbLwK+zcq0b+Aj0oDMqcp0keFEMcy0pHm3R/CszQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=AM57Dk1k; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so186035a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 13:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1729111208; x=1729716008; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MEKOnh1s2+0Rhw9pEZcf4Hw/wzdiXLK0w21/+OOxAS0=;
        b=AM57Dk1kulhp+iUb2dXt9CjNnCjXs3HjIihLmB1tmD5yzn3BP899NA1hH6dgLvZSYx
         MU7fibYMBwDo33TBc0GGC9nFS55o5Oo9YiesTMOGSk6EVEDQuARZcKRmQUNWuN06yHuv
         gG7oq2XOUzdNrc2ZiOOV+iE81iDr+jipUME1IFxKkB79aRefByOix49PXytKioGNvOex
         PWM4E1nwcQVjN8lbcauSQNiQihixUx72+23HK21xAp8TsTs9e/gF37LmYMUr01ZMHYUc
         8cXMSGCvepU/FXBVNRl7rul/y5nJ1Ei/BXJOOQUl5cCOSnwB5zlTrNlPb4Rz+Lgfabnk
         lGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729111208; x=1729716008;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MEKOnh1s2+0Rhw9pEZcf4Hw/wzdiXLK0w21/+OOxAS0=;
        b=D5J+wl0cOIwH1xOsMjrkVLSRlcJxMhLww0j5S+6fHbZvmSYyDqcrhi8PhzyMHlF86y
         SxD5FM1Gi8jMK8S/XjamjPDD3bmue/4Odie5stvqtfe7E61aVyZy27xuoLwsq1tMYlu3
         BngssvFfA+dZfPA/A2+n+RxMgzCV5ywE3E345qoGb+Dpi66Z4G4XRJNh9e5p+zhVQVMy
         RVY//ZGgFXcOapR/xCEXS/ch6CgpRzxIhpQ3nKuPDyCWJ5q37vhreZvzGX8pKpRbr9Xq
         t7sJGAIsTF6pGEHS9SlL7GzcC3fJMGOnkY5Phjcc/BUf4HY0X4571krTFOHAZotX81LK
         83Ag==
X-Forwarded-Encrypted: i=1; AJvYcCVIz7aHIeKLOgqH+At7urg+NCYEP+oHt9dXrqCdM/9NH8/2GlNXb6OXZ/s0fGgZxj3Kh7kgKQ7rchXaCy9hzg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywie62+aIASfvIgi5U2LtgkOgV09VMK+mL7FhbCkqOPSgCiigeh
	7F2v5urcxC92i9nXhH8RAGu4GckdLp6qaCouBkMyu8bqGzmwE+uTH2F0Dg2g1xnEYnv87B7qy2n
	A9aU3tB9jq4gkrkzRYSVI/+1CxiZmCl9CENbL
X-Google-Smtp-Source: AGHT+IEbFFROjL1FU0OCz7I4lJZn5uKKHUhDn7xSQ7tnQ99D4R9aHpb71O/gXX3HUDgGL1eJ9e6IjJEbslXU5A37su4=
X-Received: by 2002:a05:6a20:db0c:b0:1d3:293d:4c5a with SMTP id
 adf61e73a8af0-1d8bcf3e6e8mr25964774637.22.1729111207840; Wed, 16 Oct 2024
 13:40:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 16 Oct 2024 16:39:56 -0400
Message-ID: <CAM0EoM=G_eRhdCgMX--H=U+9phAbxwyW4-Y3W+t_ZFtgQCqkPA@mail.gmail.com>
Subject: 0x19: Dates And Location for upcoming conference
To: people <people@netdevconf.info>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>, Christie Geldart <christie@ambedia.com>, 
	Kimberley Jeffries <kimberleyjeffries@gmail.com>, 
	Lael Santos <lael.santos@expertisesolutions.com.br>, 
	"board@netdevconf.org" <board@netdevconf.info>, lwn@lwn.net, 
	linux-wireless <linux-wireless@vger.kernel.org>, netfilter-devel@vger.kernel.org, 
	lartc@vger.kernel.org, Kathy Giori <kathy.giori@gmail.com>, 
	=?UTF-8?B?UnXFvmljYSBQZWppxIc=?= <Ruzica.Pejic@algebra.hr>, 
	=?UTF-8?B?S3Jpc3RpbmEgSXbEjWnEhw==?= <Kristina.IvcicBrajkovic@algebra.hr>, 
	=?UTF-8?Q?Mislav_Balkovi=C4=87?= <Mislav.Balkovic@algebra.hr>, 
	Bruno Banelli <bruno.banelli@sartura.hr>
Content-Type: text/plain; charset="UTF-8"

Hi,

This is a pre-announcement on behalf of the NetDev Society so folks
can plan travel etc.

Netdev conf 0x19 is going to be a hybrid conference.  We will be
updating you with more details in the near future on the exact
coordinates. Either watch https://netdevconf.info/0x19/ or join
people@ mailing list[1] for more frequent updates.

Netdev 0x19 is scheduled to be in Zagreb - Croatia March 10th-14th.

Be ready to share your work with the community. CFS coming soon.

sincerely,
Netdev Society Board:
Roopa Prabhu, Shrijeet Mukherjee, Tom Herbert, Jamal Hadi Salim

[1] https://lists.netdevconf.info/postorius/lists/people.netdevconf.info/

