Return-Path: <linux-wireless+bounces-1243-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC79181C881
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 11:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E581C223DA
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 10:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82867199A7;
	Fri, 22 Dec 2023 10:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzxGiy8/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FC219443
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 10:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e39ac39bcso2169845e87.3
        for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 02:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703241943; x=1703846743; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=so/WctqVtjfM5iflr/1POr81SGQf99XUDuHNd/qhOgA=;
        b=AzxGiy8/3uZpIQnpIIme8HdWRqXTFqeep5DGPgBUojjiL3in7zzYAHKWgMiLiiH/mQ
         lE/kfWlJFh5hlgY1tPH03GPUNGeBgJnMIjmCiJM2QOBxHNsHplteN7fOb0A+wqUKdmsQ
         yEuBCxg/0budC7GHUZYkTh+d0OXIr7SPOO8vnDa05sv9Kb22LEarNog8Vm8ljE+A+fW+
         mOa+wG0H9yWNhHWe9rS0i3mTw6pURK7jliy9Q4QM0R06+E6jz7+oMZZNMDv5Br9aCpmR
         SvjhfFNJFMA4Nq2PWp4DhoeETuC4g5ft+HiTs/BZEFEWBQiWGGjWZq7ZIgJYniGMe/Hb
         6W7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703241943; x=1703846743;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=so/WctqVtjfM5iflr/1POr81SGQf99XUDuHNd/qhOgA=;
        b=uJPg/4MH8GtjzMxZMz8N6p05Rqvtbn4Oz0vZA5IDEllGNHpJqaEiNpAis0UQrr5FQQ
         Ux8h6HrzrO1fevVZvAZeENpH5XR6CFwQyAMnlJQ1IhriHgLxeZ/76XjrK4mEcR8Fs1G8
         yKX2OisrSWh+JZdHZXY1gYGa/uUmAz/JL7vzPq6ROkFYTTETmgbXtjHf6iAORDPIouRK
         Dt4EzffFD80wN2ZSkbAoySLfhFknIbdYz8RzadTduQBndUfJ58Ki8tWr7J90YRNu0pS5
         JA6NJ04ymJsEpWQVY1AemTdErfYpkG9SMJzjx/lQyOJYYsWubOld0NsE1BE15E6czj5H
         hDeA==
X-Gm-Message-State: AOJu0YzNfDMNua3eCwW8kXoOEzPFQlvXXzPDiG1tE+nqIU3mFtQvMLie
	QfFrALu4A6YvSq4J2IULepj8F+JqC6VNmL0gGLRqgAef
X-Google-Smtp-Source: AGHT+IGKkcRM2fCtGfsMvb8T7P14Zz7zxbO8VxErDtb1zLL3Mis2attZgoRLN+yOAx9xhp/UYXqp0XUYX9wf1kIa6WM=
X-Received: by 2002:ac2:5feb:0:b0:50e:6978:ad1 with SMTP id
 s11-20020ac25feb000000b0050e69780ad1mr221381lfg.27.1703241942502; Fri, 22 Dec
 2023 02:45:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: James Dutton <james.dutton@gmail.com>
Date: Fri, 22 Dec 2023 10:45:06 +0000
Message-ID: <CAAMvbhF1GbgND_-h2yT=E5vgaatj6gUXJSt3tHo==TSeJOaj_w@mail.gmail.com>
Subject: Patch submission instructions
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Where do I look for patch submission instructions for linux-wireless ?
For example, which tree should I rebase them to etc.

Kind Regards

James

