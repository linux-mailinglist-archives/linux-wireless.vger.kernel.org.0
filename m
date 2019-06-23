Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDEE4FADE
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Jun 2019 11:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfFWJIo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 23 Jun 2019 05:08:44 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:38812 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfFWJIo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 23 Jun 2019 05:08:44 -0400
Received: by mail-ot1-f52.google.com with SMTP id d17so10581884oth.5
        for <linux-wireless@vger.kernel.org>; Sun, 23 Jun 2019 02:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oPc3n13Pbv1lPi85LZDE1q7wCfwy+SyzvdQdT7/lojs=;
        b=D+QCili1iqU35eNLq6eQfwwSwz57pujcmufRwbPDwXy7sgBKx6foIxuJe2V5Ea8Rem
         olEBykDwymRJqFrprnRPMuw35hdCpLdkuhaNoAlG25+rjYmzgXcYE8udC1o7J0N1qd5y
         fMj6z95gQCOKVxD04vhMFlr+KaPOkQltRmBZ4974kcyd+tOF3fmtCsckXrcZsOFDiIMx
         tyDDKYup2iuj/6VpMskZNWb6ZeUGnNywUWneKuopdp8rLFmPcryjnOXTqdZwcPBzxyhi
         iymXwnpB9G1ADvZCs5wxq7m09M3j9ndYaJN6VzeCAv3ssxOm2wO+b2quXwVB7RDL8k/K
         5SJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oPc3n13Pbv1lPi85LZDE1q7wCfwy+SyzvdQdT7/lojs=;
        b=YaoPmHzF7NUEgPS3k/1AN+1BGgdj8ClZepHis4i4zZQYmwk2GhwYbyZmuzP3ruXGw1
         nooRN31/C3O+sDRnKVFcxXQCOkIJziVM74ll7fAcXINk/N6caFtiUS8Fuu6uOfWlLw7y
         d3qs582hgIhzQmWn1YNXzo5Ke0Krd1xWKjFesUNF6r1hGc4hYf1HUvgUZ/EOEvQu81JF
         HjenbvsKcB3aQpFRI4w8oiU8auig2zUd6qLyn+T4oyD9zFV+PvUtGx6W27zYa3MJOCvw
         h0bm9SPfdzcCa/1GvbnJWVyA932cl4oY0yUOwSNgk+j+m8n+ARg+GpnjLUeLwp93J+Wz
         D9yw==
X-Gm-Message-State: APjAAAVY4B6rxrugTMRaH3E1a+zUVGfgGo45ek4J8xEW68zLBM1AyNxD
        mnN8KLBGKvEWreWPsYPw8eDsvQ4zBKstTIvaBf8=
X-Google-Smtp-Source: APXvYqyj5Ptvjud6WKwWxUOsnEbhEpLx9ImOUoCIFhaRqrqhy5NmyiInOTsB+ADPpHCJMYxdsE659KIl1mNk4T1us2Q=
X-Received: by 2002:a9d:61d8:: with SMTP id h24mr46637369otk.53.1561280923327;
 Sun, 23 Jun 2019 02:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <2455026.F8Aexx8IWb@zadesk> <2696773.yqXG4m880n@zadesk>
 <CANUX_P3jUBREM=cwLHs8LE+ZbUVKGZNsBWGGepbS-mcHq0w9ow@mail.gmail.com>
 <2021645.iB4347jUHV@zadesk> <CAPuHQ=Ffq_Gw_KbyjpzR07MWz=+LxmGVEP2-Tn5zDxrUEuxrZQ@mail.gmail.com>
In-Reply-To: <CAPuHQ=Ffq_Gw_KbyjpzR07MWz=+LxmGVEP2-Tn5zDxrUEuxrZQ@mail.gmail.com>
From:   b.K.il.h.u+tigbuh@gmail.com
Date:   Sun, 23 Jun 2019 11:08:32 +0200
Message-ID: <CAPuHQ=GLgDFQZDhGv34S4yhOXTQL7AkKOywSqqtyPD8Lv6cCPw@mail.gmail.com>
Subject: Re: iwlwifi module crash
To:     Balakrishnan Balasubramanian <linux-wireless-list@balki.me>
Cc:     Emmanuel Grumbach <egrumbach@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

devices/ is probably just a symlink. Try to find it manually:
find /sys -iname remove
lspci

The interesting thing is that my iwlwifi card started to do the same
thing just recently (some weeks ago). However, I do suspend a lot and
it only happens after resuming, but not after every resume (maybe
5-10%). It always came back after restarting except on one day when it
needed three restarts, so maybe mine would be more about needing to
reseat the card.

> On Fri, Jun 14, 2019 at 4:54 AM Balakrishnan Balasubramanian <linux-wireless-list@balki.me> wrote:
>>
>> The issue occured again today. I tried to restart the module
>>
>> > echo 1 > /sys/module/iwlwifi/devices/0000\:02\:00.0/remove
>>
>> There is no folder 'devices'
>>
>> zadesk% ls /sys/module/iwlwifi
>> coresize  drivers  holders  initsize  initstate  notes  parameters  refcnt
>> sections  srcversion  taint  uevent
>>
>> > echo 1 > /sys/bus/pci/rescan
>>
>> Attached the error when trying to rescan.
>>
>> Thanks,
>> Bala
>>
>>
>>
>>
