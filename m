Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC1524BC50
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Aug 2020 14:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbgHTMoR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Aug 2020 08:44:17 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41407 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729521AbgHTMoJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Aug 2020 08:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597927447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=igXIVvajZYMKBSh30l418z2ksog26ZFY0O7EeHjDQnI=;
        b=M8N3lZJlSDm2eV2MHHw+Sg5lVX0Km6u3lzzora558nK7yzMGoiyi0Va5OURFTjC4YStgOp
        VmszmwY7Q0xnnAt4gBDGm1pgvnfgzCXAqejmxrqRepm1P6+K+3UMODAmxdXJVlqCRMOa5j
        /0Ls0XLv/M33rGIIDmVkEilKnJ0bLEI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-bhKCPbhkOkKSQPbSjCYGRw-1; Thu, 20 Aug 2020 08:44:06 -0400
X-MC-Unique: bhKCPbhkOkKSQPbSjCYGRw-1
Received: by mail-wm1-f71.google.com with SMTP id g72so933082wme.4
        for <linux-wireless@vger.kernel.org>; Thu, 20 Aug 2020 05:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=igXIVvajZYMKBSh30l418z2ksog26ZFY0O7EeHjDQnI=;
        b=XPNx6V5W58afHFu3kuWjiavgGYP+gMpVZXba4aFalOSIY/HcNgnGNLyG8jlY+kPgNu
         1uMH/K6PO0/Im7VaO68WRg1UGa+V5yurkncy8/sClQn2Ph3t97yqLyOVOI5YPgZCYo6d
         X/w8iwUn5ZBFtjDCU+9XRujKz7fYdLt3oRw7wXy6cYSuRoEv8XxZT403RICakJfDZCFI
         8PB07xET+P/HTo2ZqyUd2LxOccP/dVNNyk+Bt+FpkZTyoJEO8TP3RjeJ8DWPBbPnNk6/
         p0yalQYcHGKuGIhXvvFNW9J6fOkRcuj8tzQxAa/TNFyJ9odb7DHEimFIe86JAjPcxEB1
         ULkA==
X-Gm-Message-State: AOAM5315bv2jHe1Se7JkT1xC/qGQmj2EF1ymq6NvELpnKIzGSgLk2f2O
        BbFkfgoN86WH1+6iib2c/9OJQw4TjdEagzt+9j3jftdcqVEZktpbzOqt4QPK5EOs7KM6T+jW04t
        23nhkSmGH08oNjUGRlJt3JD1AK1g=
X-Received: by 2002:adf:a112:: with SMTP id o18mr3278437wro.73.1597927445252;
        Thu, 20 Aug 2020 05:44:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDWMCbTxltzkNp5xGhfTHyRx3GftozwGqp+Er1DISgl4Qp3x3JL2D6xv0ZLx1CfTh9GCRfqA==
X-Received: by 2002:adf:a112:: with SMTP id o18mr3278426wro.73.1597927445112;
        Thu, 20 Aug 2020 05:44:05 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id c14sm3884087wrw.85.2020.08.20.05.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 05:44:04 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1D65B182B55; Thu, 20 Aug 2020 14:44:04 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH 5.9 2/3] mac80211: factor out code to look up the
 average packet length duration for a rate
In-Reply-To: <20200813155212.97884-2-nbd@nbd.name>
References: <20200813155212.97884-1-nbd@nbd.name>
 <20200813155212.97884-2-nbd@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 20 Aug 2020 14:44:04 +0200
Message-ID: <87imddzduz.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> This will be used to enhance AQL estimated aggregation length
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

