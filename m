Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28947FDBF4
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 12:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKOLHu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Nov 2019 06:07:50 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49730 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726521AbfKOLHt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Nov 2019 06:07:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573816069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aSh6xGrYNC0/3FtXsYmWbhof0Fm7YlOyF8JB+VTCQa0=;
        b=DMkkXB3Ds9s/o/tPDp914OumuT2G4m+AsEfAbDYNymufqzs1CXm9lKvmuEBdw/dK2HTKgE
        s9aIww4iPkzaSJl+Y/qmOXxKoQxNn1WewXTRKlU3wlJrM9RVWKV/8+XZsrxvLQEADhjmfX
        qOT1ldgIOwSgnNIFRe3PAQYGT133DXI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-vF0dCEOJNrCkIOYuAFawLA-1; Fri, 15 Nov 2019 06:07:48 -0500
Received: by mail-lj1-f200.google.com with SMTP id z26so1451200ljn.5
        for <linux-wireless@vger.kernel.org>; Fri, 15 Nov 2019 03:07:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=bJ1QOydp+nS0bezP5EPO9Xpjocdb3Kh3rbJOybJW9Zc=;
        b=sQAxw18vCLbfOxC6T3wK0yQREjcygnrkedsI21y3I5z4esY9bKGC4mOO2rlm0bM8cI
         rScQN/6hrXfVkwhyA05lMZoX+nCAe6bSV1pOGek+im5TOC8buVATFCD/nTVY09Il3fe4
         HpdSMOKAAUIlKn7vCMJHSfVXIZQTzrVIaMP7o6WLKHueUqEMPXtNNMDJ0v+Tj7605Qy0
         LAVOU9LBybWeMgbPqQovSVSCQW591gtG5VZQhtpcN4yL0FE7nDdSID4TgI71roVqVwnj
         yMLpf/qCZMPjtA1YXNA60kv97fxyOTeyo5oiYyHk89AoLvx7OL2cAITBCzyAtwCVY0bP
         NbSA==
X-Gm-Message-State: APjAAAVRgdfb99Vavzewm8TjXtV+mz/tPj/9foZV8HFMrNfFgCHTYEVX
        +Lzu71ifSgXeMtlf61azVdndNMDZ3Elt/GMYM8vFtK+EMv/bwWWU7XDwcqKeuYcXCtTIfTxR2nS
        bg4QlYac3RC3FTfO8TlI1+DIwSvY=
X-Received: by 2002:a2e:89c2:: with SMTP id c2mr10609188ljk.161.1573816066386;
        Fri, 15 Nov 2019 03:07:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqxg5RAKCOdAhFzMwbeYLFF5AfXi9x1nWgK3JmMqEnqKHSYO91LyNnB1M+uAQUl9QHL/kS9P+A==
X-Received: by 2002:a2e:89c2:: with SMTP id c2mr10609175ljk.161.1573816066235;
        Fri, 15 Nov 2019 03:07:46 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id 68sm3997726ljf.26.2019.11.15.03.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 03:07:45 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 264601818C5; Fri, 15 Nov 2019 12:07:44 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Ming Chen <ming032217@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Ming Chen <ming.chen@watchguard.com>
Subject: Re: [PATCH v3] mac80211: Drop the packets whose source or destination mac address is empty
In-Reply-To: <20191115075942.120943-1-ming.chen@watchguard.com>
References: <20191115075942.120943-1-ming.chen@watchguard.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 15 Nov 2019 12:07:44 +0100
Message-ID: <87sgmpmm7z.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: vF0dCEOJNrCkIOYuAFawLA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ming Chen <ming032217@gmail.com> writes:

> We occasionally found ath9k could receive some packets from Linux IP stac=
k
> with empty source and destination mac address,

How does that happen?

> which will result in the driver cannot find the station node in TX
> complete. And thus, the driver will complete this buffer but without
> updating the block ack window.

If it can't find the station, how is the packet transmitted (and
affecting the BA window) in the first place?

-Toke

