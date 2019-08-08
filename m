Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1B386BD5
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2019 22:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390281AbfHHUqM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Aug 2019 16:46:12 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:40764 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729780AbfHHUqM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Aug 2019 16:46:12 -0400
Received: by mail-ot1-f43.google.com with SMTP id l15so66884325oth.7
        for <linux-wireless@vger.kernel.org>; Thu, 08 Aug 2019 13:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=pFPMDnppBgftqs+ZWbDh3lXOqVM8OHhT8P3g9JOD6D0=;
        b=cKNqE1U0+rddru/0fdQwy6G9/ANg6JswzFO1QlfO8GXLPs/hYSDpSHYf9fnQjQKmF7
         L5EWbwBYrpOTLIJ5Pfyefdgx8zj7P1xZPZ7lYevrob3DEnQ02g1pyyxNZ7ceRcAGczO/
         7TQQAfvnbsbDxEKd89wcWjNefouLWmm2NDCiEdwQPU+7ptlbRxM1Oic2Cdy1V5UUhg9S
         471u1dYYi417Ia3XOOZWcBUjJya1sk1V1gnQWC17U7Cj7XatUyb0H1MyKkrYhYpxfQRb
         jnYuV5VVbuzjTFaGg2LVhRCiQe7NpP5/b7IY266DNuIEwJGrnp5NvXGOmbbUjlJhQx98
         q4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pFPMDnppBgftqs+ZWbDh3lXOqVM8OHhT8P3g9JOD6D0=;
        b=iudWIr39oHGFuE4e+XmY76jO3va6LkVsXfZN3gG+L1j58NBEyapdCo1gaZ0mrok3F9
         6uAs84UU5f1JlICnUDBA3j09Y16hI9l/fqCBFVsvuFkdkyaNuQrLbtLtT7/H+1wEbFBO
         8dR1k9qTgp6PpEgefn8C5eRryXUZEPScc53ou0V+o1ssX5ONr492NPWQjxFth9Oqk12l
         ZWr1kojJMEwZ3uBA71IDjrUmBDIz6+ewZ19Vt+OYP6qIkEQmkv8cDYPs6gQlJYGug4L6
         LWjR+iSFolCBmNZlOwKcchOtNLp5HhklqgE0H92Y9aHr0Q6t/UFKY4qF4i4uSZ228nqB
         xJ4A==
X-Gm-Message-State: APjAAAUZU7QH/eU7e+kx5lyiDNwlb5k+8597Y5ydF95vd2lEMazHWR73
        6+2ESw93qAsHd/jxe7eZ8NnnztFxXXJgw6bDmJiiGx9YIDA=
X-Google-Smtp-Source: APXvYqweqike5FyG185jN1FMmwGNRae+0w6Bf2I5cJcJAROym1mWyd7OzUNLwmnfRa9Htaf+qHnCwvcxtC7fepNMniY=
X-Received: by 2002:a6b:cd86:: with SMTP id d128mr17072987iog.234.1565297171342;
 Thu, 08 Aug 2019 13:46:11 -0700 (PDT)
MIME-Version: 1.0
From:   Roberto Riggio <roberto.riggio@gmail.com>
Date:   Thu, 8 Aug 2019 22:46:00 +0200
Message-ID: <CAKkT90bAG96tSWnPjB+OJ2xxACY8+mPpA4jB4xhNZNv1ZZCZKg@mail.gmail.com>
Subject: MTU setting for frame injection with ath9k driver
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I am working on some frame injection from userspace using the ath9k
driver. Everything works fine without aggregation. However, I would
like to inject some A-MSDU frames. The problem is that if I try to set
an MTU larger than 2304 I get this message:

ifconfig: SIOCSIFMTU: Invalid argument

Is this a limitation of the driver/firmware? Is it possible to extend
the max MTU?

Thanks
