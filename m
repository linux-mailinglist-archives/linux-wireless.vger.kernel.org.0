Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDE3C3067
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 11:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfJAJj4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 05:39:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58372 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726461AbfJAJj4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 05:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569922794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mh6wre2rKFFqyiOsqUY6NZ90QmROWYjjTocjJiWZidA=;
        b=bvqJYoueSekMkW8BnbCd4LMUvAvg9tmFs6w3HfaFp7JkRAmoO9iQzV6AbIvgQ3nQpO1vkP
        sYVMCXf3hP6ohCeygFS61OdqWm7KtAX61G/DqXK50977/EhWIxwg0L5iopJQQ69xevwotV
        GAUqHT6Bxer2r1Ly0UqPz9fJdDjVpsQ=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-uCh_FY_rNTKk3ztvjI2EXw-1; Tue, 01 Oct 2019 05:39:51 -0400
Received: by mail-lj1-f197.google.com with SMTP id p14so3869023ljh.22
        for <linux-wireless@vger.kernel.org>; Tue, 01 Oct 2019 02:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0AV/qi7FN67vmYSpoNF3PK6oGKufZjhJSMJcgKxRuIA=;
        b=huEKCSKzDpNtqUMfYgrqNw0mgoUEjvkGM70CBQGxnYjztNsyOteZF/DWryCQS6eGPC
         K3B0SThE2GrdGGAN7oJmjB2Alum1X+a53OgqGmf8Ifhby6kztwvxxQEqPU2zgKsz9mKN
         7uQYLJ4s0F4EW/JU8QccgkDDQOSHIxGnSOfNQO5UYl0k+OEod6nVrQ4cze6jdPVAg+IV
         An298Jw2nPRzsZnWbrvU+SdYhuM7zmCl0Wt/BkavvRHoBDCR8ncAHk0ZZ8w3Yzg9Ofoe
         Utkrui7TNt6S9JJnPaY3bJXpHrtGQ4jTE8MQn3HoAce4jYzIouVE68cB5Z5H78HfSMIc
         YsAQ==
X-Gm-Message-State: APjAAAUzs4RNK1+Th7caRpD2tnxdqjgopMZDZZ1EIEEhprVf3p8KeukJ
        FiKmgIIAHmg61xbVa2n5b2d1qaef3LhFpQnLbNiRvTeej+sB9elXNrbk35i5fH9bte7CuuKmuyc
        D0KEaKLfjJXoZ/LBxG1pNxglrjdQ=
X-Received: by 2002:a2e:6c08:: with SMTP id h8mr15479809ljc.28.1569922790270;
        Tue, 01 Oct 2019 02:39:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwGMSw164aG5ltB2LcIDkpApPaI01p7En8Y8A9n9bACvqs0ay9eDmIcxo4GknUnVI3zsrCrqw==
X-Received: by 2002:a2e:6c08:: with SMTP id h8mr15479799ljc.28.1569922790142;
        Tue, 01 Oct 2019 02:39:50 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id h2sm3859139ljb.11.2019.10.01.02.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 02:39:49 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AD83418063D; Tue,  1 Oct 2019 11:39:48 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH RFC/RFT 1/4] mac80211: Rearrange ieee80211_tx_info to make room for tx_time_est
In-Reply-To: <e8d37726819f1b8eb51b370960a9be75cc9eaa26.camel@sipsolutions.net>
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1> <156889576534.191202.17686228416284995279.stgit@alrua-x1> <fd0d467d352177ac20100239cb18f80310b43fa9.camel@sipsolutions.net> <87v9t8vnn5.fsf@toke.dk> <e8d37726819f1b8eb51b370960a9be75cc9eaa26.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 01 Oct 2019 11:39:48 +0200
Message-ID: <87lfu4vm6z.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: uCh_FY_rNTKk3ztvjI2EXw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Tue, 2019-10-01 at 11:08 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wrote=
:
>>=20
>> Awesome! Any idea for how to make it work on big-endian systems? I got a
>> splat from the kbuild robot that triggered the BUILD_BUG_ON when
>> building for m68k. I assume it's the union with codel_time_t that ends
>> up being aligned wrong...
>
> Hmm. Pad out the u16 part of the union by putting it into a struct, or
> perhaps it's enough to make the union __packed?

Yeah, another level of structs would probably work, but wanted to avoid
another level of indentation. Although I guess even that would not make
this the most-indented part of ieee80211_tx_info ;)

I guess I'll look into the __packed thing, and go with another struct
otherwise...

-Toke

