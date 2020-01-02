Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A316712E3E1
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2020 09:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbgABIZb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Jan 2020 03:25:31 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:41828 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbgABIZa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Jan 2020 03:25:30 -0500
Received: by mail-io1-f53.google.com with SMTP id c16so34020951ioo.8
        for <linux-wireless@vger.kernel.org>; Thu, 02 Jan 2020 00:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=FUdWkfgPwXVvpyVuVohuohLpNkZUdBi8aQgGViq7OEY=;
        b=TiCisqTJiP1JYvWMxmQGoITHgMJusYuZVeu84U7i84RNt0j/36wJBfjGIWDkTp6omU
         ftU9mamUC8dVS32OfNcog/nDzeTeYoi6eJWOQM5rjk9zTNcXVYRMe0xbOo0SkrbiPSV6
         UwhQrdO5ieh3NVjOb5bj/xQ1lXoKtEgAHcUMem5PEQ7usSGQRRmWRemHzzl/MJepv1Rn
         F1INX0K1L84ZzyH2IWW/cay59GGDvYnNxCuj6qngATPMWu0ZQVfMp0wqNaZ4LObWPQlc
         4YwQTUGu+LQha6+dqSGTEkVtS9XjDDYXemiQkoSBbkRw/oVNjAPqQ6MMwx2DhUfvuqFm
         zOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FUdWkfgPwXVvpyVuVohuohLpNkZUdBi8aQgGViq7OEY=;
        b=F+/upaqrLnW+BJ3kfAcVF9QHJLBuKj/g2upbQdgkHF0oOQK/NDIYIgxvxoE0YnxQu1
         GnkFZbUATMzJykxIxthnSIvr5FQdKkrWaXlSOH7WpjWdJA5Nkq5+TMkXMOP4upnKs3AS
         bheFNHL8quJ0AK20hzcbI+ldS72AfNSxDGqXZ7l3xqznnSFBB0sEJilaHMqCDWb2giCS
         BdncW4GyqYMVaa/eJ3E9xpxNM60mjEEvQPIJiAnB3j8iOO5P5YXqTGT9daBURMSeCHT7
         rpnEgLKtvrX5x2wjsap60tQolCvXUG24mfeIexLkoaxj+fyEDfWiJUVasaCYE4vOjSdi
         bXsw==
X-Gm-Message-State: APjAAAWWAcyPeg7gDJHDta1wGrFChgFkFUM2YmK3hKOoZ+wCYdOnFnJN
        BerOPmR9rg3wHMS/43mn6J0wJEM8YVclSboOFLILOQ==
X-Google-Smtp-Source: APXvYqyWbZ5adt7VbJo9Gga8A316HRPYgj65+4JuKKYo+x/EJ+23zUd3yxD/+BdFShR7UbPsOKiK1awDHydomhTzqmk=
X-Received: by 2002:a5e:cb4b:: with SMTP id h11mr48689707iok.302.1577953530161;
 Thu, 02 Jan 2020 00:25:30 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac0:aafc:0:0:0:0:0 with HTTP; Thu, 2 Jan 2020 00:25:29 -0800 (PST)
From:   JH <jupiter.hce@gmail.com>
Date:   Thu, 2 Jan 2020 19:25:29 +1100
Message-ID: <CAA=hcWT0a28hDZa12J1n3LhQf--DKzdyqsFJ-E5gooPgubctUA@mail.gmail.com>
Subject: Error message: mwifiex_sdio CMD_RESP: cmd 0x23f error, result=0x2
To:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I am running Marvell firmware sd8801_uapsta.bin on imx6 kernel 4.19,
but I have following error message, could anyone explain that is the
error about?

mwifiex_sdio mmc0:0001:1: CMD_RESP: cmd 0x23f error, result=0x2

Thank you.

- jh
