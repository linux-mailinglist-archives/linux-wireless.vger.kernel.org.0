Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B54E0992FD
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2019 14:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732895AbfHVMMG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Aug 2019 08:12:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42194 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730980AbfHVMMG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Aug 2019 08:12:06 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0E51364132
        for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2019 12:12:05 +0000 (UTC)
Received: by mail-ed1-f70.google.com with SMTP id z2so3271222ede.2
        for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2019 05:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=9h83h1p/qy02LMcxTntGw58CIiMA2cd2aWOiL/YUHAM=;
        b=HHHv0iv9uqAhagnLYYQuvMFxl6JT6zivrcnxhC90UdPvAdDU/8LRvha1wHpE8YqTym
         7Euby4uOYewN3Q/5uEvSsI1Wi1zM9H819leL9B6XR+Jw0HDKhGR2hydKcqO1VwL5H0Za
         I4nXJ/+Gmq6oS/g8hiCpWuKReq1Dif54LeomS4cJeKX1KU4t9Ri2FHG6bvsJE/+6wl4G
         9BAopuDAtcMiR5fWcsZBLul0kiUL3FasbVENt8pG5SG/2ZUtD62HO98EsnmRNTUHYtGR
         nbrvMMXHJWL4OHcPPV0pmsKfkrZpIzUnZyLB+kuNOeEBWVgiFIerZ7A9uG6jDFY8s8Rq
         3pbg==
X-Gm-Message-State: APjAAAVTC7Y6lpoaE42y9FalkROmGcGprX16A/YMZakYnRB0z9NalYSA
        3UbOeo4cHZtk6E4j7i165FDvboxSZzOxt0UzorktIqdHHBTaDvcZaSomEBgKboCEZERjXshYQAK
        BU4Wp0bTdzqPMBTFcRk8RwPz+2S4=
X-Received: by 2002:aa7:d043:: with SMTP id n3mr7422556edo.258.1566475923862;
        Thu, 22 Aug 2019 05:12:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxfgFd0pqx/wt/2/8MBMZSdmQSjSFql9LbG8CrRYzr9Cjm4n9JWISkqTDdPw9bSmMel8QQqmA==
X-Received: by 2002:aa7:d043:: with SMTP id n3mr7422537edo.258.1566475923726;
        Thu, 22 Aug 2019 05:12:03 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id e29sm4798065eda.51.2019.08.22.05.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 05:12:02 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9BBC0181CEF; Thu, 22 Aug 2019 14:12:01 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Wen Gong <wgong@qti.qualcomm.com>, Wen Gong <wgong@codeaurora.org>,
        "ath10k\@lists.infradead.org" <ath10k@lists.infradead.org>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 4/7] ath10k: disable TX complete indication of htt for sdio
In-Reply-To: <86d0eabcc63849efa914f2c14a3cd59f@aptaiexm02f.ap.qualcomm.com>
References: <1566302108-18219-1-git-send-email-wgong@codeaurora.org> <1566302108-18219-5-git-send-email-wgong@codeaurora.org> <87blwkt480.fsf@toke.dk> <00992d0991704b0fae73a500bb2eb504@aptaiexm02f.ap.qualcomm.com> <8736husub0.fsf@toke.dk> <86d0eabcc63849efa914f2c14a3cd59f@aptaiexm02f.ap.qualcomm.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 22 Aug 2019 14:12:01 +0200
Message-ID: <874l29pffy.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@qti.qualcomm.com> writes:

>> -----Original Message-----
>> From: Toke Høiland-Jørgensen <toke@redhat.com>
>> Sent: Wednesday, August 21, 2019 6:10 PM
>> To: Wen Gong <wgong@qti.qualcomm.com>; Wen Gong
>> <wgong@codeaurora.org>; ath10k@lists.infradead.org
>> Cc: linux-wireless@vger.kernel.org
>> Subject: [EXT] RE: [PATCH 4/7] ath10k: disable TX complete indication of htt
>> for sdio
>> 
>> Wen Gong <wgong@qti.qualcomm.com> writes:
>> 
>> >> -----Original Message-----
>> >> From: ath10k <ath10k-bounces@lists.infradead.org> On Behalf Of Toke
>> >> Høiland-Jørgensen
>> >> Sent: Tuesday, August 20, 2019 8:24 PM
>> >> To: Wen Gong <wgong@codeaurora.org>; ath10k@lists.infradead.org
>> >> Cc: linux-wireless@vger.kernel.org
>> >> Subject: [EXT] Re: [PATCH 4/7] ath10k: disable TX complete indication of
>> htt
>> > When this patch applied, firmware will not indicate tx complete for tx
>> > Data, it only indicate HTT_T2H_MSG_TYPE_TX_CREDIT_UPDATE_IND,
>> > This htt msg will tell how many data tx complete without status(status
>> maybe success/fail).
>> 
>> Ah, so this is basically a counter of how much data is currently queued
>> in the firmware?
> Yes.
>> 
>> >> And could you explain what the credits thing is for, please? :)
>> > For high latency bus chip, all the tx data's content(include ip/udp/tcp
>> header
>> > and payload) will be transfer to firmware's memory via bus.
>> > And firmware has limited memory for tx data, the tx data's content must
>> > Saved in firmware memory before it tx complete, if ath10k transfer tx
>> > data more than the limit, firmware will occur error. The credit is used
>> > to avoid ath10k exceed the limit.
>> 
>> What's a typical limit in the firmware?
> It is 96 data packet in my test. It can changed in firmware code.

Right, I see. Is this counter available in all ath10k firmware, or is it
SDIO only?

I'm asking because this could also be a way of implementing something
like Byte Queue Limits (though I'm not sure how effective it would be).

-Toke
