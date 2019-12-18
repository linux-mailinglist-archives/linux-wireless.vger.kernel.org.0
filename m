Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8326B124613
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 12:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfLRLsn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 06:48:43 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36794 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfLRLsn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 06:48:43 -0500
Received: by mail-ot1-f65.google.com with SMTP id w1so2196479otg.3
        for <linux-wireless@vger.kernel.org>; Wed, 18 Dec 2019 03:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SF+iiSVsBKQmDSLLYDr33/ZnGLsk/vtl5947FDvEZL8=;
        b=l2b4A0iSD6L0rlZ6zNCCW11A4dRjGzUvNofQM/v/mSDFWi0Dc3/NPZk6z2v7/1R9j5
         X7eENMZZglUV4oxYgJLXsNLBfW4c2Fh5a4JRVF7F1g+gC9HQob2E4hDoAFSxdshkY8Lb
         63ohxznYfIyshSCT1qln9gr07lVNwbLN+cbSsDocwj3E1t3flNFS0QWBEVgKWRt9FRXP
         z+BHumNhfrNH5zuyUeGgxppgC3xfqv/K/mcmx/I/JYXd51WKYtaCi+pn58DF7eWy1WiQ
         pBa82N/2U1lmaKK80viTS3w/kEWES5KQliOi9WG4xYXKo/+estdn0osGQbj/a3kty6AQ
         Gx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SF+iiSVsBKQmDSLLYDr33/ZnGLsk/vtl5947FDvEZL8=;
        b=AtDtVWw6zm0kF/u8iI3kVb6AntCo8KXxqPmym66B3gQ0Hrs9oYG8rT9/sTg3a7+h04
         /+6CNWFBVsYjqTXm/fOSHVXi8lSDOzw7SBZ1vGKQvZL1WBbbCRgjdTAO3IE3dyJeAdUF
         7uR5Dm8zgJ/NTQyCNG1XJpgE2yfqFApJB9LVQIlodbCzm/BacfRpSWDc0c1mAym0QDn4
         86mHleWM8+RAHqsdDN0BwDKE/NReNzdGU/Z+bKn1ZMIHeNLiOotEHgUGq4058e1evJkc
         8mcvaUh+umPB1GRrD4Sq9w8PyCzE/t1/O9cIWP+WTL+eXhOiB/ik4C3WOsYNQK+VYjNY
         5bDw==
X-Gm-Message-State: APjAAAWdyh5iWF/oryMEEKRksQ6EVlBtZAixuwoUY4wDiWKFk6cgDTSr
        eC9oeuOu0UDXmV+wLA/D3TAIHRmAgAoZjSo52V8=
X-Google-Smtp-Source: APXvYqzQV1FPZ2Cxlzj9tp/r0uOyvlbLOAKv32nbZd1F53Yl3UUQYN0w75vyBYlo4qxKyVLY2CT6bLpUMhee3H2lFf0=
X-Received: by 2002:a05:6830:1116:: with SMTP id w22mr2247658otq.63.1576669722352;
 Wed, 18 Dec 2019 03:48:42 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:362:0:0:0:0:0 with HTTP; Wed, 18 Dec 2019 03:48:41 -0800 (PST)
In-Reply-To: <9431f1a2-a44e-9b81-72b0-9a703e1841ac@newmedia-net.de>
References: <20191216220747.887-1-greearb@candelatech.com> <a2af03e9-8b53-b297-467b-d0f07b8a002b@newmedia-net.de>
 <b5d63d96-4ba6-bbab-bf1c-a61c6c437f37@newmedia-net.de> <80700614-679a-336e-bd9a-e88622e75c9a@candelatech.com>
 <4775d91a-9719-46f8-b0f2-979b8d86cf9f@newmedia-net.de> <CAMrEMU-vGB8uR-JZbD2vj4vXgWNHfFqcbsqB=gOqBBDZWGkzQA@mail.gmail.com>
 <11290a30-46e8-638e-4110-86e6b2eb3d3f@candelatech.com> <CAKR_QV+xNbAzzw12x3Ku49bHnERTxYRAK8AfUSwp_uOgNMbY4Q@mail.gmail.com>
 <a95e7f6d-1cb8-3188-aea4-233dce6f9330@candelatech.com> <CAKR_QVL0P4qYidtqLwhhacCOpx2iq+4RRhTXbGhfRnf2PUj5tA@mail.gmail.com>
 <CAKR_QV+KV1dR_QKjANL34DGJuyf3OSN8J6gs3bqcmiRCCzkdXA@mail.gmail.com>
 <5e3f22d1-b8ba-d756-a15c-1e7ae56c1dad@newmedia-net.de> <8eae96cd-a94e-abc1-4750-73f931d657d6@candelatech.com>
 <9431f1a2-a44e-9b81-72b0-9a703e1841ac@newmedia-net.de>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Wed, 18 Dec 2019 12:48:41 +0100
Message-ID: <CAKR_QVKhe37QnRvfE0-0pHTjBtjMoTsZMMn6SkP+iV4HN8rRnw@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Per-chain rssi should sum the secondary channels
To:     Sebastian Gottschall <s.gottschall@newmedia-net.de>
Cc:     Ben Greear <greearb@candelatech.com>,
        Justin Capella <justincapella@gmail.com>,
        linux-wireless@vger.kernel.org, ath10k <ath10k@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 18/12/2019, Sebastian Gottschall <s.gottschall@newmedia-net.de> wrote:
>
> Am 18.12.2019 um 03:37 schrieb Ben Greear:
>>
>>
>> On 12/17/2019 06:12 PM, Sebastian Gottschall wrote:
>>> i dont know what you want to compare here.
>>>
>>> 1. you compare 2 different wifi chipsets. both have different
>>> sensititivy and overall output power spec
>>>
>>> 2. both have different amount of antenna chains. which does make a
>>> difference in input sensitivity
>>>

both were connecting to 2x2 AP. 3x3 card should disable 3rd chain in
that case but driver doesn't do that yet.

> anyway. while this calibration is running, the signal and noise floor
> might be unstable or even bogus until this is finished and rate control
> might not be optimal
> under stress conditions like long range links with low signals.

i've noticed noise level switching between -105 and 0 on some high
5ghz channels between 2 litebeams (not very long range, less than 5km)
while signal levels are in -65 - -75dBm range
