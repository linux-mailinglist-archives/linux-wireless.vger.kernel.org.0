Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACB93C31F8
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 13:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfJALFc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 07:05:32 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29861 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725900AbfJALFc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 07:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569927931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AVsvHTUiJXZiUPgFBdi2gYHsvhhqAGRgG/FQ9DspGVA=;
        b=ax9k60Ec5JBeKE3t6Jkdhd/m/JzHUkAPmjFulqEUlut/juAz9YrZed4qFySQufPmSRBRR4
        rmOU40TbJ+0PxN6bJQs8yI5efp/pu+PK1hSXAXn+GI1WwwyniwckW4918YbGY+Csi1bSl5
        3N93oSdwQLUeMDOEUcey7Zn/nXGKMQg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-kVx6UefkPqSPHB3vZRGwPQ-1; Tue, 01 Oct 2019 07:05:29 -0400
Received: by mail-lf1-f72.google.com with SMTP id z24so2682285lfb.15
        for <linux-wireless@vger.kernel.org>; Tue, 01 Oct 2019 04:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=wZ8bNOH9jek4T+XHr/OU+DDOP2RzN2cpsfXiL6JbaUI=;
        b=JaZ8Oyk0VCMle7K7FSLYNPGQmF3xsmrh2L7EC6GgXUCVxDDYr0dSA0PIYxlgwU6+IA
         rjXyEpEhs0FM2cr46j1hfemjdVq1a+Z0uvRsJ7zUmZ2VcwahvcxMI+Ch/Be3+mml5tYd
         8rmj+HAMzHBNdWOjpEojZkXy3LabwR36cCDDBAMbiGkGPZkVKaUGtJmlL63RZ8DB0jT6
         M9lojLpFqNa39BHKRL6ya/rFejv2tTG9P0S+5rYecu/aCuUbrwvnsdr/j4fMbKBdLKJ8
         /tSGZSQaj/6T24MWmLuGVNVKL/nKAE+zbooS5J1bldOe+uuVTFk/74PTliw0pMaAIdqP
         Y36w==
X-Gm-Message-State: APjAAAUhVQSbKjXt/aw2IF1APTKuf1KjuEi/IrOiEn4jiFOqMnoJuFFc
        tMzgAx+IyZ7I5PxOi/GE9wtYZzh8hLK37bOF+YO+MxAPypjs7cdPZApEt1BxAh4iZEn+R9WKwi0
        KJ7Mie/a2c4eoQWmvUjnYJ38M/Aw=
X-Received: by 2002:a19:c709:: with SMTP id x9mr14963895lff.20.1569927928264;
        Tue, 01 Oct 2019 04:05:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzBVgLKZr5yvTXsALkox4es6JwSriEe1mdilE3hADu18nrdz6KA4qon5+J0W04TXCIDLoMOMw==
X-Received: by 2002:a19:c709:: with SMTP id x9mr14963892lff.20.1569927928115;
        Tue, 01 Oct 2019 04:05:28 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id s1sm3842557lfd.14.2019.10.01.04.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 04:05:27 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 99A4018063D; Tue,  1 Oct 2019 13:05:26 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Yibo Zhao <yiboz@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH V3 0/4] Enable virtual time-based airtime scheduler support on ath10k
In-Reply-To: <e710a18d65ecaf2168a27556c85dada8@codeaurora.org>
References: <1569223201-1490-1-git-send-email-yiboz@codeaurora.org> <20985660fd0872db1511948bd42cd925cef13cee.camel@sipsolutions.net> <e710a18d65ecaf2168a27556c85dada8@codeaurora.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 01 Oct 2019 13:05:26 +0200
Message-ID: <8736gcvi89.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: kVx6UefkPqSPHB3vZRGwPQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yibo Zhao <yiboz@codeaurora.org> writes:

> On 2019-10-01 18:19, Johannes Berg wrote:
>> On Mon, 2019-09-23 at 15:19 +0800, Yibo Zhao wrote:
>>> This series fix some issues when enabling virtual time-based airtime=20
>>> scheduler on ath10k.
>>>=20
>> Given the lengthy discussion here and also over in the related thread
>> about AQL, I'm assuming you're going to repost this eventually.
>
> Yes, will repost once Toke have updated "mac80211: Switch to a virtual=20
> time-based airtime scheduler" with his new ideas.

Which in turn is waiting for the AQL stuff... :)

-Toke

