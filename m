Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 641CFB55AD
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2019 20:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfIQSxN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Sep 2019 14:53:13 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:44551 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfIQSxN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Sep 2019 14:53:13 -0400
Received: by mail-io1-f49.google.com with SMTP id j4so10066773iog.11
        for <linux-wireless@vger.kernel.org>; Tue, 17 Sep 2019 11:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=oCRH0dv5NZqO3HO/Yn02XKQbO3PvKw51qMlXSB95LNE=;
        b=PH0gpPeJ5p/FsXyQbNJUUzjFcqBp9tRITwS4p5eVbmfwEqKG4MDSJw8ycVboXjaqgk
         QxLvgfbWNkGJoSP+OcjBeHIz7rPyuR/wf0ntJHcrk36UGZiXVOvV6lbWhT9YfmMPSHs2
         Wj9VzI5GabAmuk+V+ETJTFRn4Jkd/Ij5XFHJoBKDDvK0lsj8GP7qYgZgGkNWx3d6XSqv
         zaSd1RAtCJHPUaWZu51YR5rE2PmZqo/gRkzgkb7dqCZUKdNxD24BInL+kGLxy1SucNJ7
         uF4Ud9YKBVfSmR82gz9Vtpw3mhLc9PzjdUJJ7Cu2auWy2rjzkz9rGwnm2EQao51g2NKQ
         zJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oCRH0dv5NZqO3HO/Yn02XKQbO3PvKw51qMlXSB95LNE=;
        b=kebgjq+3Q4VK1oBcqo1Ld/foO18nj3OnUZeTK3FSdrKgH8KGy7LTnDffK74nRsgy8+
         ZzhzjCPLxh6fY9MeuVXPr/hf68321Oz2HETCQq/PW+Q6d7ZnfVQ1322JcpyZD6eke0U+
         VgIBPs9nMTEgCgc5jK/oYO1zN3Z/pwJ+1cDPla9W4RTUuB8sq+YbahpsEIB07bA7mPNY
         PrJ20dVafMLlAqfTO2n8uoe7NWdlbFHdCpA1Dkp3KSqwAJe160xBDf2zXDcwwhU3NOI0
         PoxElyShvRqaHdo2vJyMBYvWwas1yMs8zcoSnwCj+87zNHPoCh1cFJsRQqqmVFNGf/70
         eJJA==
X-Gm-Message-State: APjAAAXQ04WWdbAWpTx9z4SBHD9jkKXN3lSG75SKZ/qeknrwl+DmPgAQ
        dbpEccjq6imwMu3U1hinO15CBHyuj/j6Jj5Pi8zEoqlEkvQ=
X-Google-Smtp-Source: APXvYqxjAKWFkWmlht3ubkHoJWb3jpycD0D/eoxP63CEohYqTosJA82/hvIJW3VMWZi29lUlxM8q/OtmjJpUVxeIJ3Y=
X-Received: by 2002:a02:65d3:: with SMTP id u202mr5932574jab.12.1568746392053;
 Tue, 17 Sep 2019 11:53:12 -0700 (PDT)
MIME-Version: 1.0
From:   David Ho <davidkwho@gmail.com>
Date:   Tue, 17 Sep 2019 11:53:01 -0700
Message-ID: <CAKKzd-8jgQWTO2w589gMVJm3CaU-15wUER+fsqpYJJSeZL4RPg@mail.gmail.com>
Subject: Linux wireless times out at Google Starbucks location
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi there,

I found this issue with my Ubuntu 18.04.3 LTS setup at a Starbucks
location I regularly visit.  I have tracked down the problem and at
this point, I think I will need the wireless subsystem folks' input
before I can proceed.  Can you folks help me with this?  See my Reddit
post below for details.

https://www.reddit.com/r/Ubuntu/comments/d5l79f/linux_wireless_times_out_at_google_starbucks/

Thanks very much,
David
