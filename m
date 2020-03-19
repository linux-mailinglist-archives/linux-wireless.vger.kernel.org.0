Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6306618C0BA
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2020 20:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbgCSTuW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Mar 2020 15:50:22 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39800 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgCSTuW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Mar 2020 15:50:22 -0400
Received: by mail-ed1-f67.google.com with SMTP id a43so4255509edf.6
        for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2020 12:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MFk5i2iiXtU50QkhlM+1rTn5+B+gPnQ/5B883R6gq5U=;
        b=VNUVm5O3V+eVH292HyWNwL1SFfbB/t1faA4Ry97i1PCmBBvjmB7btgOWJj4H687/Bb
         5WoAvTc47P/dchzjxXYy4/xIgPD82ZQHbOm+1kjGOlmvHj5u/1hbDjmlcQtyqvQNTTOp
         mEC3aqROdXGwPmQ8iCynj6g3Wl+mI2tWDJBFmR59VhuyByTDFI1etc/2eDf8AbICQK7W
         zFTvksdmJ3yV39Vp0eIGLnS23Au3q98k9zHN6BW/IlmWBcRC46RnRdbv7hx0DeDAS2qb
         X1ASja2CnpOfIktVlcmMjrMY7s2rnI5EWZqONUPYYnY9k9M2+U38Gg7hhvgC4Va02sLb
         NX+w==
X-Gm-Message-State: ANhLgQ1reD9/80dRdEHmgqGumIC5qAxMPDwby4a7M7TBggBAzgdt0m/1
        eIdnh73Ta1j8pu3N8k2tIb0Hw4FRDidF99+C6mo=
X-Google-Smtp-Source: ADFU+vvqXbxUPqNrGib6H/au8KnUJLaPorlPB/ylMwfKH4Rgb0AGqfapXk29cpLvqaEBCvY3OIxpU3utebaFpAUE0Gw=
X-Received: by 2002:a17:906:82cd:: with SMTP id a13mr5030705ejy.70.1584647419726;
 Thu, 19 Mar 2020 12:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <iwlwifi.20200318081237.46db40617cc6.Id5cf852ec8c5dbf20ba86bad7b165a0c828f8b2e@changeid>
 <20200318213440.GO311@earth.li> <CAJvTdKmrKJQee-WrG4UCo0FYrr++Er=mftrdLKjcCuy23N+HPw@mail.gmail.com>
In-Reply-To: <CAJvTdKmrKJQee-WrG4UCo0FYrr++Er=mftrdLKjcCuy23N+HPw@mail.gmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Thu, 19 Mar 2020 15:50:08 -0400
Message-ID: <CAJvTdK=PbQh9uqN2P43p=ZYvYtf6mxZgyXveKrhgr+w3nUuBCQ@mail.gmail.com>
Subject: Re: [PATCH v5.6] iwlwifi: don't send GEO_TX_POWER_LIMIT if no wgds table
To:     Jonathan McDowell <noodles@earth.li>
Cc:     Luca Coelho <luca@coelho.fi>, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

BTW. also verified that this patch (with a small offset) applied to
5.5 and also fixes the problem there.

5.3 and 5.4 always worked fine not requiring any patching, as the
regression happened in 5.5-rc1.

thanks,
Len Brown, Intel Open Source Technology Center
