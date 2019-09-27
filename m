Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE93C003F
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2019 09:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfI0HqX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Sep 2019 03:46:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33869 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726177AbfI0HqW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Sep 2019 03:46:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569570381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aQOfi10kSSeYzsWnIT0tqo1zy5k4UjraHk0oJTLoIqU=;
        b=DdFF+UZBrnOiffRnkwqFTjSpCaMhdNbUd+BbcmLxd+AE1331m8ytStn5lJPVC5RoMWvV8d
        e2WRNRTLDVGcAfOG4fPQigjTXNr7Wj+wwV9prqNLoCvIrBcn4jqCFntN8O/e0Z1cZIFXp+
        G/rcf4HrhoV+CWZZ5r3Y9YAcDmMzDpw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-Usr7167RN_ixyQKmoHlnIA-1; Fri, 27 Sep 2019 03:46:19 -0400
Received: by mail-lf1-f72.google.com with SMTP id c13so1173731lfk.23
        for <linux-wireless@vger.kernel.org>; Fri, 27 Sep 2019 00:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=aQOfi10kSSeYzsWnIT0tqo1zy5k4UjraHk0oJTLoIqU=;
        b=UNusqsifElCL+mJz8JmEgndQ0SES48Iz2IuhONLQQsFU6Oei4b2TGBzUsRyI0lcBZw
         9wtjTALUK1HyMKDHPWDRyv+QRdH1hWFVqcTXC4kOPpl9iAM876tu49Xc5W3Wp+Pyko44
         VAuF6dcI5jCbA8k6alN7AEVCJe5HgWgD4LkwXDIjjTwCiTt81TGT0EShTpAvVnAtigod
         sZ3uWimNbzoZkPLYIjKIQ54Gu5RgW6pjwRcmwyEzClxyvpodQtrYZwhRjFIWSpivA7t1
         S/4Jcrx3cyy2N/CVockOFhLBW2D6JvpJ/4hCxudd+fmCDarRixIhJ1QAM512FLqn9KEd
         Yocg==
X-Gm-Message-State: APjAAAVKOkcNmJ0bjjQ5ewBSwshBxobWqz4NkRzLnl8t4LoFUcULcOYd
        KtGD6LEJf7JVQHIvb4SyGYqchYg51GR02dFSlDmrnRIK6ARjfbCbo5bhNFBaUchB4bocPRIQWc0
        yVJwqOgstVNWe5kaPnBITgpbAgKo=
X-Received: by 2002:a05:651c:104b:: with SMTP id x11mr1841051ljm.218.1569570378189;
        Fri, 27 Sep 2019 00:46:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx8FHJbPlqVN4d7nONRrbB3RnKzvZFrOOzCTN4evlSWnXBT46OzSnm43C4+rvlQ9Q+RP8yVxg==
X-Received: by 2002:a05:651c:104b:: with SMTP id x11mr1841047ljm.218.1569570378062;
        Fri, 27 Sep 2019 00:46:18 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id b7sm322084lfp.23.2019.09.27.00.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 00:46:17 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BE39818063D; Fri, 27 Sep 2019 09:46:16 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 15/15] mt76: enable airtime fairness
In-Reply-To: <20190926174732.42375-15-nbd@nbd.name>
References: <20190926174732.42375-1-nbd@nbd.name> <20190926174732.42375-15-nbd@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 27 Sep 2019 09:46:16 +0200
Message-ID: <87y2yayyev.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: Usr7167RN_ixyQKmoHlnIA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> It is supported by all hardware drivers now
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Very happy to see this! Emphatically:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

