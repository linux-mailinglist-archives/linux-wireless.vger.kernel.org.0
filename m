Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39F9611E29C
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2019 12:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfLMLQK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Dec 2019 06:16:10 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:41598 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfLMLQJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Dec 2019 06:16:09 -0500
Received: by mail-oi1-f170.google.com with SMTP id i1so736131oie.8
        for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2019 03:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=zGbUusGmcKHHNzvysS5kwUk1GddQwYh5NDnDa6dHUBo=;
        b=osaGSDGfM0tPh1+raplBcHZz68ZqlZDak4koYhwOpun5uU6HmYjK72z9jH6ohxX2XW
         XbIkMTBrqfxRoU1SujGQoQt1QTOeo07GTAtbm7ticIWs2lamS2y5c+dm5SdfEyWoAyIj
         a98QUr7UxaLpO9ud8XiPvYl1UiTUQSxE0t41vlK0Uk3/m1alAKuXq7SmQOFdBBhYdLAb
         UjCNL9QBEsGC1Hq4Q18A14FOwYJbI/qRc8u/zasKArIhYPpHp0HEQXptNFf0Kx+9GcWO
         CYJ8iTCgrjXb9atKK5cGcGJUUOCozr1IQdpMQ1poYX4iFpUxAfpbRcALoiGF7t2bxwNG
         jcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=zGbUusGmcKHHNzvysS5kwUk1GddQwYh5NDnDa6dHUBo=;
        b=WtT9CsRics4rltEvtl/7pEg5Zddn0Yn+87YcM6oYVzGrAUVZB8i76Xrh8Xyb381Br0
         a5gMNun3gW+8VKcPXnJKk3Rffe/2xjf3VU8SEIOc4te/yW83L/taMYNQiPbjNvJUEdBW
         NQ9jApAI8o4gjB/0qz6XitZC4bPMtJApgzV7VJH6Y/jyZ6+iOLAYgKyiAAjozfBPShl6
         mA0BzwUCBObcAg6dPrEBDwz5/6UtORNlgG8GUoZbKB+FM5C8v31twGZ7wZ6wI9j6Hm4R
         T2yKAZ93lrn4G30q5V96pMjWw6b0jALpcjDWNNwVzYnvv5F559DzQEsy5LlpHwtGwTCS
         gXnQ==
X-Gm-Message-State: APjAAAWbWXfJez2T1CSLo7Oa7XoYF5IB0o5iPQUZqBufCOWqSIvykN8+
        JA/lLuCEssJrdI+38zKDHnD689O81kCHg63wHxlLTR6ES4lOxw==
X-Google-Smtp-Source: APXvYqzSNKX83LpVNNklonOI5C4CGJHCHoZjTfea2UBGAbrKu/Hk9mhTudM5cNg50G6pJMZ1ueohPde5kuNRjEX3KBY=
X-Received: by 2002:aca:f305:: with SMTP id r5mr6906930oih.174.1576235769044;
 Fri, 13 Dec 2019 03:16:09 -0800 (PST)
MIME-Version: 1.0
From:   Justin Capella <justincapella@gmail.com>
Date:   Fri, 13 Dec 2019 03:15:57 -0800
Message-ID: <CAMrEMU9Mz+0RNmmGQHic_cWPf45LHeK3Mzcy6a=GuYkvgdN+RQ@mail.gmail.com>
Subject: qca988x fw crash/unrecoverable pcie errors causes error loop
To:     ath10k <ath10k@lists.infradead.org>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Paste: http://ix.io/24hJ

I think a station went out of range, and somehow that crashed the fw,
but when it tried to recover it was unable to read CE, and so fails to
recover, eventually an correctable PCI error occurred but *80211_ in
an attempt to reconfig is trying to stop all interfaces, which
includes stopping aggregation for the peers...
