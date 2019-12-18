Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0144123BAC
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 01:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfLRAgt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 19:36:49 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:33377 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfLRAgt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 19:36:49 -0500
Received: by mail-oi1-f180.google.com with SMTP id v140so206185oie.0
        for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2019 16:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=l+5X5vMQ6YkQcZtac3wkcM7mV4o2WEa8wKesrwPdpfo=;
        b=miRzFCkvA1IM/AfGOimn+QqAvoCqJbKu6sDr+xpJu2T7jjuVJR41/7N4Q5LbV2bPY4
         asMf2nkeQpPBeIFOVh5H4Qpu3tI9tkhEYPXn6qkjjqSRkNQFKnZxNNR63KihF/aoEzLj
         ghU9yhJY5OxxBDbQmeSnWWhnixTefgB2asjdLAppbISTbjeGGMzpczAC64KRIo0Ni1qz
         2YIzBtjVc6rTT3Oax1IxlKEbuWHJDqcVXyyQMTW4K4DJFnGX/Wz29SksL3ErbE5pPkFr
         M/r8Zq/gg1qow7RIzGB77gzkjJJLzfb+k4EFr3ajgn520NLI6IqcddkwRh/XIA1DEJ09
         PYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=l+5X5vMQ6YkQcZtac3wkcM7mV4o2WEa8wKesrwPdpfo=;
        b=M8txjWtilJ7tTwgoyl1BlMcOekrFtz+NJYHzuklU2aajz+NNXrpbiqBiL+gpL3Eth8
         FYrKXY7rYVq+ojSGvUMJgfJg8eWzcOnKaHaOFy2bdQ4Aoymi081TOgjeuZBg1WQY3Hsh
         RMMQU2v06ZbYlm8Cn9hOz2SmnEqG0y+9RTWH1UHnpgW+8/c0mKiNmrKMwXd1+1tPNdh1
         ytKR6c9rtpVUyZoRQpK787GbcD7VTXbkQe0rSmjKCVRcmZKHNJ1D6nX0mjTCGJ8Fc4Bl
         o+A1+PG2Xmtccj0FP+gmEiK/6XemFCSXZEiVw0oYDJJlXEQwYPH0AjlNjguELSVNfhxP
         Mbcw==
X-Gm-Message-State: APjAAAWoOyqCB9IP71qQN4Pifk1C4Zkxgn8EcpOOwCp2Vz8T9yZxSGbB
        PcKvdDOVjQbrkr8gZbY7QNrnpSBtvbhMAXSFHTc7Yw==
X-Google-Smtp-Source: APXvYqxX9UgXZHIY8njDh20T1lCIcfy4T0iDtyDTbrKPQCfOA0oKSz9ip/2F3uZMvNTntqP5KglSfEbPxHQy8lLtCYs=
X-Received: by 2002:aca:ea43:: with SMTP id i64mr119364oih.30.1576629408473;
 Tue, 17 Dec 2019 16:36:48 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:362:0:0:0:0:0 with HTTP; Tue, 17 Dec 2019 16:36:47 -0800 (PST)
In-Reply-To: <CAKR_QVLabBXcsPfcCt8MdQXUrkgw5aNVAJD9XUke-G7XhsTwAA@mail.gmail.com>
References: <CAKR_QVLabBXcsPfcCt8MdQXUrkgw5aNVAJD9XUke-G7XhsTwAA@mail.gmail.com>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Wed, 18 Dec 2019 01:36:47 +0100
Message-ID: <CAKR_QVK2fJkR6OveFAhcjqjToh_mJMxfvjD6vJssqVtpmbQkGA@mail.gmail.com>
Subject: Re: [RFC] ath10k: possible RSSI recalibration bug?
To:     ath10k <ath10k@lists.infradead.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

some more testing revealed it might be NF related bug:
https://marc.info/?l=linux-wireless&m=157662586107288&w=2
