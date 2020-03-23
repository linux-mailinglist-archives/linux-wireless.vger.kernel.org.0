Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB62190035
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 22:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgCWVWu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 17:22:50 -0400
Received: from mail-il1-f172.google.com ([209.85.166.172]:38089 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgCWVWu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 17:22:50 -0400
Received: by mail-il1-f172.google.com with SMTP id m7so10700763ilg.5
        for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2020 14:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EbA8FdNJjwQMT1rHQOM610PWrPT67DNBGdbF0KgJNBw=;
        b=WPN1yFeTFS8jk6QHxyG2r4bT+6Ake0ojqiofJXqcQ+ql1hniK+tPrvVZVJejV0t2wu
         bqPUPNchFkvn7szCLIUyf8YXHnI8pS2uoo4SfhWwONskcCsEfCa8+LgNCUzOgE7SWehT
         bp5CtHtj5VgYG1eYjpEUoHJIFIsTyxMolIr9JfgCB+JBLuu5FEKSzKH08UicaJb0/k7N
         EK1vM4WADeauV3SJ+vkpB/P0+DGW2qY1YoqEMkF1KpduB2Bkc9rYQM6YKwSOZK5J7MYn
         u9KAmdIy1Eg84tFd/F0tfgWmEU/ulHGBDvpjw1N/sLrO6wqU49pfCHJEwz6QZu6iTW0S
         fbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EbA8FdNJjwQMT1rHQOM610PWrPT67DNBGdbF0KgJNBw=;
        b=HGQ8KcyHjezTfEVN8Qp2dAMoLGy1aiVvBG7mbOHmfeF6py/Rud7GLzgJLjR/3GOrb6
         hI//iZ8ejNkxSiYHmqrBp4Olu22AbtApcGxUQe9/FudOKaYFScydiFx0qrReGIhB1WaW
         2LQvQrNK+7XcikkpHt2TMbTITJYEAh1D0sJDqq6z5i6xekMhrqpowSA5MMHw5U5m34Am
         +Tgcut/KcZv4GlQbU3bMpkSI20OWfHcJZP8dj4V9R8r7HQLDrDmL0UGfIyaLsm0IIfAj
         u0lxFvLyCVBX877HWSr9LcC/LwEjZxC3e3/teasMXAC2pRBMiLCIdaxPAH9GIeOQClbe
         Gt7Q==
X-Gm-Message-State: ANhLgQ39uBIJ4r09/GDaMxvBj9j3YPSZAVBFHPJYW7FvZKgF/DJ7Nv+5
        Zh/Xg2ZZr8izs4/+2zSnmchL2oHXJKFJGvd5NjE=
X-Google-Smtp-Source: ADFU+vsZL/BaWdRPuva+rr7KzrtLTyYm5+kQM6pKE6IU9cijtMWfbjl/03dK8Pdp01g3YXmjGWUotqBAGjWFQ+RpaRg=
X-Received: by 2002:a92:d20a:: with SMTP id y10mr23695677ily.1.1584998567864;
 Mon, 23 Mar 2020 14:22:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:7714:0:0:0:0:0 with HTTP; Mon, 23 Mar 2020 14:22:47
 -0700 (PDT)
In-Reply-To: <BN7PR10MB27370353B542954AD795D77E9AF00@BN7PR10MB2737.namprd10.prod.outlook.com>
References: <BN7PR10MB2737FC3E7028D66FE34351C09AF20@BN7PR10MB2737.namprd10.prod.outlook.com>
 <CAKR_QVLLe2nssX3fz=xtPvM8ZQKwGpC4g=YOyUUkaniX_KB8QA@mail.gmail.com> <BN7PR10MB27370353B542954AD795D77E9AF00@BN7PR10MB2737.namprd10.prod.outlook.com>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Mon, 23 Mar 2020 22:22:47 +0100
Message-ID: <CAKR_QVLvQUKCORmdJCqTz8JVoeo2-TYxkvj5p2RzoLNetKY8Vg@mail.gmail.com>
Subject: Re: Firmware Crashed
To:     Ming Chen <Ming.Chen@watchguard.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 23/03/2020, Ming Chen <Ming.Chen@watchguard.com> wrote:
> No, it will be very difficult for us to upgrade the kernel.
> This module(QCA9986 PCIe) is from the a third party company. They are using
> the QCA driver and it works well. We are trying to integrate this module to
> our own device(PPC-64 + Kernel 4.14.83). We don't want to upgrade the
> kernel, since it will be a huge challenge work for us.
>
>
> Thanks
> Ming Chen
>
>> -----Original Message-----
>> From: Tom Psyborg <pozega.tomislav@gmail.com>
>> Sent: Saturday, March 21, 2020 11:16 PM
>> To: Ming Chen <Ming.Chen@watchguard.com>
>> Cc: linux-wireless <linux-wireless@vger.kernel.org>
>> Subject: Re: Firmware Crashed
>>
>> can you try to boot it in another device and using some distro that
>> has 4.19 or later kernel without backports?
>

My suggestion is to try it in x86_64 PC. Then you can just use live
linux distro with different kernel versions. If it does not work with
any of these you may have ran into a hw bug sample. If it does work
then you don't need to update your PPC64 kernel but find an
architecture/device speific bug that prevents it from loading.
