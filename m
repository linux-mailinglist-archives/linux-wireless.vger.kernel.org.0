Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD52011ABA
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2019 16:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfEBOEC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 May 2019 10:04:02 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35207 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBOEB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 May 2019 10:04:01 -0400
Received: by mail-vs1-f66.google.com with SMTP id d8so1437190vsp.2
        for <linux-wireless@vger.kernel.org>; Thu, 02 May 2019 07:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=9PosnaKNgclfK+qhKAvGvjnZZQWcdMigJpZ1M7CjYaQ=;
        b=hEbVkvvvOltVqNlQsAu6OCW/zeiQuRLdq0kVLy5y8SiyajJ4F+EIGkHBZlmRENIK3A
         V/1opfATmV895te15L1514Ighbi44uPEYhCEi7+aNaS3SvZHYxS5pnUtEV+Kw5Z7hQYD
         7llc40DYvZGGxUBs0mdVsojfv80c2rsisgz7Y5If4hKYkcPyLpWt2y0Rgzy1D0bfzHmZ
         2Fg49tw4vyAyfcSlrsoLuoATOL/Pu8pdZTJsFSk2ncphstHjkpY4j6w30JnoIlH7Oysi
         gbMhxK8j9A3KM9I5plR1oZFAQTPbz9u3r/uLSwgQ9ImE8Osplcn/OLPh2OEG7858pPu2
         oceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=9PosnaKNgclfK+qhKAvGvjnZZQWcdMigJpZ1M7CjYaQ=;
        b=Se901IQVw/aOqPpGRN53WDSBJ1O4AGn+8iYRAf+aMIGqojHCrsQfnbv5IVYJ84DBHO
         ANwbcylrpREC6IDX6AvO2+EkASJYGSAh5qBHgGGaSGwxalZK42660GyKuCzLMSLpfdBI
         6dy1CEeug1pLIxtzazFtJZnmFqSCTc8PhD+NxXAMS0cbyUIBGdRWfFBQEwH3wn2FqN1o
         50dXj/3mOwZ3Po9JTCLGU4RzIIEnM+RdO7i6rb7cj2Il6WiuhA9j+UrB0Ug+6UVanuMv
         ZMJhXb0Dr/kr2dbi8NsKMKUmRoavkSKw/OKQUn4B5qEhc2YJmdnTT2WS1wOPPI8Lh7aP
         Y0Cg==
X-Gm-Message-State: APjAAAUUFVOj2XsYZdytCeMoeLF8dBX5BlXIv7na9ywSyYZ/nAzOszKQ
        jmtN12I6lSfWTxOmLRgQaTm9kyVswkztJfZiKw==
X-Google-Smtp-Source: APXvYqw+m7BeCaP46Hr5tCt0+lls1oCZXkYntgBuE+z30mYjElWIGwyD+Bskh8bF5hdinZvA0VkMbV34wjuVE7OE2pc=
X-Received: by 2002:a67:7f8b:: with SMTP id a133mr2128778vsd.38.1556805840424;
 Thu, 02 May 2019 07:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8WD_bTvWWTeh6BP_qgByiuWLbSN==CTBY1KD-v8XpWZkf_Rw@mail.gmail.com>
 <87k1fawsio.fsf@purkki.adurom.net>
In-Reply-To: <87k1fawsio.fsf@purkki.adurom.net>
Reply-To: whiteheadm@acm.org
From:   tedheadster <tedheadster@gmail.com>
Date:   Thu, 2 May 2019 10:03:49 -0400
Message-ID: <CAP8WD_YFzVgvRW_yPVtzvj4KkH+f03jEuVsTRG-QHmZmv+ms9Q@mail.gmail.com>
Subject: Re: carl9170 crash
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Matthew Whitehead <whiteheadm@acm.org>,
        Christian Lamparter <chunkeey@googlemail.com>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle,
  I just tried to bisect this and got an unexpected result: commit
4c3f49ae1306c05e91211c06feddfd0a4a57fabd "Merge branch 'for-5.1-fixes'
of git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu".

I wanted to share this in case it is correct. I have a stronger
suspicion that the problem has a race condition and appears
intermittently, hence a peculiar bisect outcome.

I will keep debugging.

- Matthew Whitehead
