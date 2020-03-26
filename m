Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A10251942F1
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 16:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgCZPWD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 11:22:03 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:59904 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727717AbgCZPWC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 11:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585236121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TTyRBiiPM/GehLX4R/d+xfAxJEtf+WIdgk9S++j+6Jk=;
        b=cjVqC1TAeR/fnG93bIT4SCRE0HjWSCMWWi/yDpCaoXVLA+SFOoY85nhfRtkMjx72intZrD
        O/1MJxszUVQIPz6lC61YBZccSmPBMWLf2T8yy6926JMVfSFMdcteWD2HyqYBUkaXGn2X0K
        l3ptTP/dNZDg/QJWZQp8X78u/1zbWKA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-TmVkX2CLNKqRk3g-k7Dczg-1; Thu, 26 Mar 2020 11:21:57 -0400
X-MC-Unique: TmVkX2CLNKqRk3g-k7Dczg-1
Received: by mail-lj1-f199.google.com with SMTP id w6so758903ljh.11
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2020 08:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=TTyRBiiPM/GehLX4R/d+xfAxJEtf+WIdgk9S++j+6Jk=;
        b=snX+9ol+PlU0MOVSJTkDJeaG/m/Otv7WIkSEAELy2eW9t1ru1736uLehw7aBa6a34j
         DTG0sQpbC3JGuIVbAmgYWDfgZOWHiVN3rN/vPB6N0coMlEYKSvYdKATH5zVHwFp/eA4Z
         l2woxusyr3+jddoshIPbp7MW6x+GDkZZKp4m7K2rEp91CHNGTo7bBhqP/7RJnB9cWMK+
         0MiWI0V2pssNxx2vH1rIErMkPUK+BImBq+vQMgyaahvdA53zMtAAiT8jr/lePnCHuhGt
         GDRZ3Bi5h1r1pip9GLpDXafI+xCiticrSgmKHhG59WluMUSnjIfc5MM4EtYZK1YVQ1Jz
         KpUA==
X-Gm-Message-State: ANhLgQ3KT18gKN3tuhvfu7VNJaIllQ6Pt1xIa7olCOZibMu9Pa8SXDyy
        0PA3wJCxYyz+Z0i8A2Tx7q+7dEqDQ0/8zroQwZ4amFfJH6MfAi8bsyC+zZuv2RrN1MohwqkGN90
        4JNsKAyer2wqE62FasATZoWRiQMs=
X-Received: by 2002:ac2:5446:: with SMTP id d6mr6162892lfn.62.1585236116034;
        Thu, 26 Mar 2020 08:21:56 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtkKAcQI4kilGxRpxAJepaKReyo14QEMBIwFmujm9eQvF5/Ircy6SpEJYO5zJ5sITNx/Pob2g==
X-Received: by 2002:ac2:5446:: with SMTP id d6mr6162874lfn.62.1585236115677;
        Thu, 26 Mar 2020 08:21:55 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id o4sm1665987lfl.62.2020.03.26.08.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 08:21:54 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DBF5218158B; Thu, 26 Mar 2020 16:21:53 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     Jouni Malinen <jouni@codeaurora.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mac80211: Check port authorization in the ieee80211_tx_dequeue() case
In-Reply-To: <20200326155133.ced84317ea29.I34d4c47cd8cc8a4042b38a76f16a601fbcbfd9b3@changeid>
References: <20200326155133.ced84317ea29.I34d4c47cd8cc8a4042b38a76f16a601fbcbfd9b3@changeid>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 26 Mar 2020 16:21:53 +0100
Message-ID: <875zernnu6.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Jouni Malinen <jouni@codeaurora.org>
>
> mac80211 used to check port authorization in the Data frame enqueue case
> when going through start_xmit(). However, that authorization status may
> change while the frame is waiting in a queue. Add a similar check in the
> dequeue case to avoid sending previously accepted frames after
> authorization change. This provides additional protection against
> potential leaking of frames after a station has been disconnected and
> the keys for it are being removed.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Ah - nice find!

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

