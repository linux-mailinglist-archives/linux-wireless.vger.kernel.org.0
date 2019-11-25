Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBBAB109143
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 16:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbfKYPuK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 10:50:10 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37496 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728592AbfKYPuK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 10:50:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574697008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CKFYMDRZ9s148RvIhLyO1vrx/yx8RURD6GwVRt3ILFE=;
        b=BHsd/WIfFdrOvXzoqIx2OSVh9K11xaa4GOiYy+Tbpk+wEQTnnxDXsHmZ6shhH6KSKrTnlY
        OS28S902J8i0lhpWp8lDy0yWyquOAmiCKKht+lrwHOXN2LnVWEgyaIiJa9JT/wGwbHoBqV
        WO4I5sFAhYu4JJNeRdvNKW7K0C381MQ=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-4QWVP0peOYCBlFX_duUTeA-1; Mon, 25 Nov 2019 10:50:05 -0500
Received: by mail-lj1-f197.google.com with SMTP id o20so3088626ljg.0
        for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2019 07:50:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=20+3zAqTVjwD/q4A9N4YhOCatL9tYt9w48LL6VCgPng=;
        b=rCJD0pvM8PHIXfaDmL8TvteIcA0z71AJ9A/Z972jffUfE12nhTz+yRZgNWo2Leekhd
         1vguenxWjSXeqsaEQ9tbO21gBcZPXKYxOkoLk9f7gLLyCIMHLFr6g4Ado6rhdxy6Yv3/
         HngCbXCKYyIURxQ1HQilLJ4lWeciT7Hy4AGby8WJyLDas1nl5g4huCICQQNqMHqcO1qP
         Y93CNKDKg5NGGrSr3Aeq6VgFBIEs85HOFgdxqZuuxamS28B8RMKvi7R+9bwDjFRfMmas
         q3scNX6Fh5bqUgfknw9YTjNCiNu+NC4IlAbBYoBdredr0JThBqFYVJO5Mh8ausGSGMR/
         aMJg==
X-Gm-Message-State: APjAAAV7zOCqJT2PxYWYFWXAzniyH+OfQ+uCV66/owI8rWOeIG+o75MU
        59Kx3I09fau9intwn4bmeUsplvVQc152x3Lxo6ZeBiB0IlcI3pUpqqbu1y0FOEpF991aoXnLRQB
        UsS6AoCCvITCaqQxpwEUpTQG1SIs=
X-Received: by 2002:a19:f811:: with SMTP id a17mr20714338lff.132.1574697004077;
        Mon, 25 Nov 2019 07:50:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqz+y9yI4DrVotEUSbBjKVVN9P82pcwHk5LJky3C4sS/oGFnSJcfeqnNKyllIZGh5WOjk2/g4w==
X-Received: by 2002:a19:f811:: with SMTP id a17mr20714330lff.132.1574697003944;
        Mon, 25 Nov 2019 07:50:03 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a11sm4148037ljm.60.2019.11.25.07.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 07:50:03 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 624DC1818BF; Mon, 25 Nov 2019 16:50:02 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Tony Sumner <tony@whittycat.me.uk>, linux-wireless@vger.kernel.org
Subject: Re: wireless firmware for Debian
In-Reply-To: <20191125150414.GA1849@Debian>
References: <20191125150414.GA1849@Debian>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 25 Nov 2019 16:50:02 +0100
Message-ID: <87h82s0xcl.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: 4QWVP0peOYCBlFX_duUTeA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tony Sumner <tony@whittycat.me.uk> writes:

> I am installing Debian Linux on a laptop and it says I need to get firmwa=
re
> ie thr file ipw2200-bss.fw to start the installation. Does sourceforge
> have this file available?

You'll need to install the firmware-ipw2x00 package which is in non-free :)

-Toke

