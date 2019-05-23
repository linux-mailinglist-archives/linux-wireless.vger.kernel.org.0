Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94B2427884
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2019 10:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfEWIxi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 May 2019 04:53:38 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]:36075 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfEWIxi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 May 2019 04:53:38 -0400
Received: by mail-qt1-f171.google.com with SMTP id a17so5811942qth.3
        for <linux-wireless@vger.kernel.org>; Thu, 23 May 2019 01:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a918TbQKiXTWWro1Ti01zuEc74Pim9HFxITVNep8AuI=;
        b=hKsn6lGfmCISU9R1io0EPOvcvS+l9/IQGa7i8/5F9CgZGA+tJz5j33wRPSUJq0/O27
         VRl2of9JtqR5hnxJgY6B6+vyl4WXLxWpBMbMlf3YSwo2CUJtOQxMoAT6bu6CCaetINio
         8KrMGHw6zCNRCKAuGh1YPRt0yibSF48Mywha00NlpumbOiW+88Cb6wGr/O/2QHW4quEa
         lYWfW+phFm5RgKi3+x1SHFhbfJZIgwDBVLwDvlU7s/7qJH7VLhD4M+XYLYvc0lX0OBT/
         IOgWKeiZX36O+B31Axokl9a6OhDTBO+MOAJYWTK7Kmkc/dD64EwBqZvDrWzwYLaMqc/t
         e3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a918TbQKiXTWWro1Ti01zuEc74Pim9HFxITVNep8AuI=;
        b=pszxvSDWG2GkdKWW4znWs8KULH6qLJuObu/eJQ/oVQ7eNOScjyxV7ch9kXLKHG+mx1
         8Yy0CvshsOzmTVZK/5nGoGQs6YcwJXK7JtR55P9ujVgzItskfJJrbrFcRqJGbNzzuolT
         roiq0NjOQ+bMT9Sy/RosjrU3/FlI5W3PxV8TOxjcPOU23Idvu5H5DXBylPzsl4zvPhnY
         meP3bOlw3rHGyL/WvsipfKkf4DCNgGjZRLQOYJqNY6oQwDN2zaeKrIZHhySUrb4Pk6hN
         hB1JH1DSnu/hZZASTab1DLcvGwU75fpHVuf9NvTNbeuhzO7kRK5HdJ8UwYW5cUTKCylw
         QnZg==
X-Gm-Message-State: APjAAAVSr5QSNQ6sSqHXrOW9QAlYmWooUhJUxTbYU0zRvylWi7t7lW8G
        N53M99J6lAujLcywAYwbz/fXgOVNLwrqTyeA4RaF/Q==
X-Google-Smtp-Source: APXvYqy4Te1ZIo17lwxK9LnwTqwPOEJqIH0FwKntgAhg7pT4qeEx2k0DDYZpseAM0PxTTiYKCdTnT+VmFUZbWDoMnog=
X-Received: by 2002:ac8:3862:: with SMTP id r31mr78685121qtb.26.1558601617190;
 Thu, 23 May 2019 01:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <1558506776-19702-1-git-send-email-wgong@codeaurora.org>
In-Reply-To: <1558506776-19702-1-git-send-email-wgong@codeaurora.org>
From:   Claire Chang <tientzu@google.com>
Date:   Thu, 23 May 2019 16:53:25 +0800
Message-ID: <CALiNf28PQFtAM6uZVPhh-_ASnYeeAtm8kWpP0b8k_P6zGwxbcQ@mail.gmail.com>
Subject: Re: [PATCH v3] ath10k: add support for firmware crash recovery on
 SDIO chip
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org,
        "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tested-by: Claire Chang <tientzu@chromium.org>
