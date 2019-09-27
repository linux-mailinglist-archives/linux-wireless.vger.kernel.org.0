Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2EAC0038
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2019 09:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbfI0HpT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Sep 2019 03:45:19 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40904 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725769AbfI0HpT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Sep 2019 03:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569570318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Ia2aLBxThsibVAHwTM7qcS6oFxLod1X/XmfvZqIITE=;
        b=XYAaoR4l8U/D5qrGYPmPx8rrMob/GLFmfPyqlokhI2gxH71mVgIGE41PEqz6hyIo6H1D/R
        pkLdph3RrW4LY0PPR+blXNikvLnFAmBh1HmrMEOjLUnzy47GhowliCYHU8XSqd3SXmfU0S
        Zlv4X/Y0l8lm5XdMPBsL0SxKVwS1vFo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-BM2YPx5ONSa4azD7Gq_z2g-1; Fri, 27 Sep 2019 03:45:16 -0400
Received: by mail-lf1-f69.google.com with SMTP id e1so1216128lfb.12
        for <linux-wireless@vger.kernel.org>; Fri, 27 Sep 2019 00:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=7Ia2aLBxThsibVAHwTM7qcS6oFxLod1X/XmfvZqIITE=;
        b=tfclMXYYkZ+5orevwO/ykQ8gH10JSvi3H8loMAlK2K0YIUG1axFKu0PQONqIPCi+Xd
         AuPbwqhZ/n9BI1ni4RjOGTDF92Tdbik/i3ZcfUrQkz7r1WwZsGSrxZ6M+5TvS2aITvWc
         0Bfq/EAkdN/3lE1ZWZSGVhiFHwLL9gTuIzwZ9Qvlq91UHWHHarAfckMHixPhQSHNlrU9
         l1sCSwIGzPWbbYu8t1tX9dd6hj86v7vGL2ob1vpOSvRfTdttgxnLvr1/dQzaomTKeMyG
         8V4NE+aLpqcqpCqpx1rTyf7Qo6SHX+IwZPI/pjVzc283XAE96qncjQjeFBuic3KEFI8L
         s2cA==
X-Gm-Message-State: APjAAAX9Oa9TagOFfFOk3exQioKnxg5qLIDE9GCSb3fVayoKLjUa/Rfe
        eq2rKpCNwMkmvFIw0fzKby4Aq0rjVSLuJ9xSnI751d0gyOu5O5djHA1CTOaAC/gWKRf48C5G1RE
        2O7Qpl9pM4KFnrWdVePpT5FzkKNQ=
X-Received: by 2002:a2e:5dc3:: with SMTP id v64mr1890812lje.118.1569570315118;
        Fri, 27 Sep 2019 00:45:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzZG/ThLtdKhoBs+V0xRkeKhle9uWs1TYfjxY0LdVI4a9Vlb4u2NFs8GRj8gx0aNRlLDQYnag==
X-Received: by 2002:a2e:5dc3:: with SMTP id v64mr1890807lje.118.1569570314988;
        Fri, 27 Sep 2019 00:45:14 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id 126sm370745lfh.45.2019.09.27.00.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 00:45:14 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3AD8E18063D; Fri, 27 Sep 2019 09:45:13 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 10/15] mt76: mt76x02: track approximate tx airtime for airtime fairness and survey
In-Reply-To: <20190926174732.42375-10-nbd@nbd.name>
References: <20190926174732.42375-1-nbd@nbd.name> <20190926174732.42375-10-nbd@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 27 Sep 2019 09:45:13 +0200
Message-ID: <871rw218ty.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: BM2YPx5ONSa4azD7Gq_z2g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> Estimate by calculating duration for EWMA packet size + estimated A-MPDU
> length on tx status events

Would it make sense to move some of this code into mac80211? If we're
going to do airtime estimation for queue limiting it may make sense to
use this instead of the simplistic estimate I used in my RFC patch?

-Toke

