Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0FE11CAAA
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2019 11:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbfLLK0S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Dec 2019 05:26:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35585 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728410AbfLLK0R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Dec 2019 05:26:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576146376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LqMXRk6rCtiVFoaCtnlcwqoxrX8OCO+HrMA6kqNtJmw=;
        b=HULS1DkNSLhORD2qD2uh3vvDznfU7JyNmUo4Nz2MaRE5pTqTo0/QXXzZl+fCIB34Wuo5NE
        X6BRMIue+MPKPnzJ9lx+5CaPaGgBWmKK89/oQ3FEIh1/Hox8Js6Mb4R9qOGVIEnnFd+51h
        xXar7VVHDYuDw0B7/sykR+XZYGV4YbU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-OvzW3_kmPWSxox2Khl7YWw-1; Thu, 12 Dec 2019 05:26:14 -0500
X-MC-Unique: OvzW3_kmPWSxox2Khl7YWw-1
Received: by mail-lf1-f71.google.com with SMTP id 6so457786lfj.17
        for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2019 02:26:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=LqMXRk6rCtiVFoaCtnlcwqoxrX8OCO+HrMA6kqNtJmw=;
        b=kSFsFo+bGWk3Pc2RNxqLToUdJ4obY4fDfnLLlxj8NEfwtqpmygs+PVrXRPPHsweMHt
         rrKeGA7VMH3mtvcbYbc4yaqowIsnkuLxI0ET9TN+fbOkgxY88m/m03fuVXpi8TodEZQt
         fI1HAF+OH8Geohjlo0793ssK7PxhHAGrIiOw85sMKjIqDCHS/8lKMw7ubwQGQmQX6Gsm
         DzX1gLNv1UrPSbrFqcCE3XA7vZNglmpJGZo7fXIyewQAjQAhAKPIxn3LZKE7mVuAATFl
         EzVidujne8HiVS+EEMaWuvpUQfTX8O7MqKvL9ZDLlLfpUOd8dltloJEm7CpmdBF1NncQ
         kCMQ==
X-Gm-Message-State: APjAAAWdp1IVvnQgLZU7XMFUwXJihAQGy4dARSbNPFtZUR3FB3/p3cNN
        Orn+6pCna6eu4ihzCY61VFcDQ+6aOy2Qu1TT6mkHnAwmfqe+CxkYpPPVLwiE63y64+9nkXXUfVh
        38PHKemM7TSOAwUUwW+ZM8E47muk=
X-Received: by 2002:ac2:47ec:: with SMTP id b12mr4897303lfp.162.1576146373052;
        Thu, 12 Dec 2019 02:26:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqyvDZpljDxGbLOjgElAxiMpsUDQZBxKbrxLnG4x7lzjij8jaVV6KcLexxhX6wL+yw7sqagZYg==
X-Received: by 2002:ac2:47ec:: with SMTP id b12mr4897298lfp.162.1576146372905;
        Thu, 12 Dec 2019 02:26:12 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id p18sm2936074ljp.39.2019.12.12.02.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 02:26:12 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A1EF71819EA; Thu, 12 Dec 2019 11:26:11 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] mac80211: Turn AQL into an NL80211_EXT_FEATURE
In-Reply-To: <df7eb0b71dc9cfdc7d9b5f7abdbcce0d42fa4a1e.camel@sipsolutions.net>
References: <20191211145230.200132-1-toke@redhat.com> <20191211145230.200132-2-toke@redhat.com> <df7eb0b71dc9cfdc7d9b5f7abdbcce0d42fa4a1e.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 12 Dec 2019 11:26:11 +0100
Message-ID: <874ky5g7r0.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Wed, 2019-12-11 at 15:52 +0100, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>=20
>> diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
>> index 341e0e8cae46..1e6f435c709c 100644
>> --- a/include/uapi/linux/nl80211.h
>> +++ b/include/uapi/linux/nl80211.h
>> @@ -5563,6 +5563,7 @@ enum nl80211_ext_feature_index {
>>  	NL80211_EXT_FEATURE_STA_TX_PWR,
>>  	NL80211_EXT_FEATURE_SAE_OFFLOAD,
>>  	NL80211_EXT_FEATURE_VLAN_OFFLOAD,
>> +	NL80211_EXT_FEATURE_AQL,
>
> This is missing kernel-doc.

Pfft; since when are we also supposed to *document* our code? ;)

Will send a v2...

-Toke

