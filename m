Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3258210928D
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 18:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbfKYREm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 12:04:42 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:33716 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729050AbfKYREh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 12:04:37 -0500
Received: by mail-pf1-f182.google.com with SMTP id c184so7680388pfb.0
        for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2019 09:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Q8Y0etMiJA8Fg6G1Iyc7V4yqyP4bp9mrc2XhmhODDZ4=;
        b=xjL1upXnhhgvUxEan9YPfS2ENkzW82X4CqryT5ghQmUwyR4PYyQw1sNbKkZ0RhMNZt
         LHddgoZZwfe6/0yMd+iUGYGQ/ivMPzkXZ1oXvwB32Ky/vrgK/OdciG+YuxxihbJrIlz7
         M9JxI01ech17vkiQtUDo2eL4heCMEYzKVm2t/kzTYqJArJUJQJGCDHD7rFc+jDgAOBuw
         Jqee7b1JBJSZCRJe74lVyAZ0ltWUWbLp22DdQjicgpZ2/7jvHkvYS2YUgMZHUd5+j82K
         Do6orGVBjvq7zh2jakLwt019NetdneHXM7RWO4Hyrsp5ty2hMZG0OF7RNIBKfz8g4h0W
         Av8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Q8Y0etMiJA8Fg6G1Iyc7V4yqyP4bp9mrc2XhmhODDZ4=;
        b=umyeAYL/4/+bKtWROH1xsIB3aMmGNGh66f+aSmvJl3M9PbuLVyU04qiBBAyKd/0W7N
         cjhsIPybrcUAuyYE3HxjCGc6xoKP0bFuDVT1BUm/UpzXtycA9dcDjJldx/lWKWs73Fu9
         hbAT7IOFFuddRmb533OzbrVeroponDZWF4dYCwRsIubwBqg3/UhnRZRFWeU9BWXtjA1S
         TGuNXw6dZMlpoV87IbbtzdrufcamhJ7iucV9z2rwofPRZesy6kAhcnexvIm7I14ql8b9
         F/9n2o0AFMR27g7zpNFp3R2QcRrBaGnKn3A5SXDCXkfxMA5PQVob5P2Bcm+3+SE60ejd
         G3zw==
X-Gm-Message-State: APjAAAW3glYicnEflW/jGGITUzUg+VHaZn7Y2HSQsAEFWkSt0UQzto4K
        yhmRqxPUJ3aPu7z/peu2EkDACQ==
X-Google-Smtp-Source: APXvYqwtpbUIHwHCKc2J7U/N+MsXBLJBXnILlCbzjATOR22XpH+YtDln+ICA0c7BVEgz5by3lfq7iw==
X-Received: by 2002:a63:a03:: with SMTP id 3mr33194073pgk.117.1574701476491;
        Mon, 25 Nov 2019 09:04:36 -0800 (PST)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id l21sm8773079pjt.28.2019.11.25.09.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 09:04:36 -0800 (PST)
Date:   Mon, 25 Nov 2019 09:04:27 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Phong Tran <tranmanphong@gmail.com>
Cc:     davem@davemloft.net, keescook@chromium.org, kvalo@codeaurora.org,
        saeedm@mellanox.com, jeffrey.t.kirsher@intel.com,
        luciano.coelho@intel.com, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Fix -Wcast-function-type net drivers
Message-ID: <20191125090427.787126fa@cakuba.netronome.com>
In-Reply-To: <252466a8-2cad-7e4a-2a87-ade95365fa75@gmail.com>
References: <20191124094306.21297-1-tranmanphong@gmail.com>
        <20191124143919.63711421@cakuba.netronome.com>
        <252466a8-2cad-7e4a-2a87-ade95365fa75@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 25 Nov 2019 22:06:49 +0700, Phong Tran wrote:
> Sent in different series:
> 
> [wireless]
> https://lore.kernel.org/lkml/20191125150215.29263-1-tranmanphong@gmail.com/
> 
> [USB]
> https://lore.kernel.org/linux-usb/20191125145443.29052-1-tranmanphong@gmail.com/

Thank you!
