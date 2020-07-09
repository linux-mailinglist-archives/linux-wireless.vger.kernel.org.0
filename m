Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4E221AA77
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2020 00:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgGIW1e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Jul 2020 18:27:34 -0400
Received: from sonic305-3.consmr.mail.bf2.yahoo.com ([74.6.133.42]:33871 "EHLO
        sonic305-3.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726213AbgGIW1e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Jul 2020 18:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1594333653; bh=0B+SWGCjkrkFK/9PcmlCfBTEHs+4BcMP8kN75VVbocY=; h=Date:From:Reply-To:Subject:References:From:Subject; b=RzrxTePnWKkUQqKbpqfTxZjBjUD+EKU/ui9QMd15irE5EehXgz3dMyfkETL1tRaYprm59yZIPOxryVCyUQVOPBLQdwVjNm5O5bFQyBdVaJbwgE6zZVTdKvBTUu3tLhOLgrV/X1bDri1xAnMsKHtFc9fVznYo9Ph6iUwDCUdljToYNLITc55tYVSASg1tkF7M2w7ff5Dcl3IXarZumJqddIX9ZYcIWJofqVpRTtV25qIoNkKmDiSFnkT36gsGPGaQzCMBtTrTriqvfnqC6wKhTp1nyO+n9/TDCtYpwcmYHqeQjlNdUGQMb6tMthG6HzpZeA1C/ncAHdtbwkeTpOU8kA==
X-YMail-OSG: wh0VOi4VM1l4UltSToNIXpwvPn6pzPEYJGLcsjGHUuASbZSy8CbJw9UASfPs6U0
 J3A_ed3Hw8HXOP9kTPTXJCORZoS8HMmTj979MTWQJAIc1TUfOerKEh.JyrL59fvAv.XFwuKqM76T
 XWz9AFiER4vTXuJX1uMncUVKKDnZdgBd4t7TsbLh5bNXhqUje2OCjrYx1cFaKU6ieNiHvG2gdmq.
 I6dKbJB79Vgss5A7aIdH7Lsv.cJMyJCHizm0egEz3OfRZITlg0U2aWiNQ3BXZhlRJyd45ZZzIVfO
 m1FjTYfRWvhvp_jJEb2DtGaALB7K8nnK4JKYHtZkBJovJW4pW0HxR7at2tN74I8gd.2Bh8xupSLz
 HtMoxyPudRsVYVqx3Zuej2gf9s_iFqWdv36saj9KWiC5kmZ_zhOc5pzbZy9CBW.Z0daq_kabdHRY
 hyTrnWYgAfH1ENyqoAe62.E.jwjuACTM4AKxO1_WlCqsa0bLCgJ3vibrXNCbRoIFMbFNXW0h902y
 LDPpaaY5yI5sBHkcouC9s.btrxoMgJfw0fkHJHVo0yE9S65LSakuA4rzaIQxoTjlG6I0vvZlk2wS
 jkZqd6aJiEINvAZ6pT1q8I.LerF.hqhnDQlZTI8tpH0sxnrPKIe.aPjJ8kSQEpc2R271pG2EdQcM
 DXE7DG7Fpc6QhuyGY4HwWMqngJWqJZoM9Ic1NQIeZB5mK5akEjFRJ3ES0pYg7E0iDHVYkIDbnRSR
 FPI3EDYH25MT0cngaztfFSnN1FuKyVktijmJRASrOxkWTQ9kb4ExphA3HR0q6CzMUJ80LeQQUteN
 5NjvMKRt2jlkGvoZ73D6HWnzchIrriaOPGiPnt9r_5s8M1LiPHMgv17mzsrhV5G5wvAPQspRzoQ0
 944eXTvM2MihX7DjUOBIGUvDMBVg34tNchvr6feKSAks43vZXBYFt2oj_KZZrJZNX3NJSoJADP3S
 qljBY_r8jU.tAsBqp4zTZwC3_zCOPrDud5.UGIJF1qFqQUEItAzyo44H8FvtDL_A0_rJAAS_3kDF
 HfOWEbRRL_QgWW0QFV.G3etX6ef0iI8flntMwxT.JROzEUUehdv_T4SQ0nFcek1o5CfDg1OMPzDu
 LWODEeJFWAvSbAFib850xuD9qdQMqPf5frlOdKyOJTPQkHKp9s1IUr.IIguOICgaylE7WgP1PGqD
 9plOlryOPx.iBbo44N8gjUXAD0DZ.kqWZBykFJMbHWZCY.eY7KUYfmRPYEiMpvkxfbezOJoGmnI.
 Fm1EBhTh1yGAWLCchlSgXigdDUgRaYAHb6qoWsgkqLPVlYKHJqI8YwG3fTQYKvKT1Re88rrUneA-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Thu, 9 Jul 2020 22:27:33 +0000
Date:   Thu, 9 Jul 2020 22:27:29 +0000 (UTC)
From:   MUSTAFA SANI <samustafani3@gmail.com>
Reply-To: mustafasani281@gmail.com
Message-ID: <2043822141.2750669.1594333649717@mail.yahoo.com>
Subject: My good friend,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <2043822141.2750669.1594333649717.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16197 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:47.0) Gecko/20100101 Firefox/47.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org




My good friend,

I just want to know if you, can help me, to transfer the amount of ($6Million). After the transfer we have to share it, 50% for me, and 50% for you. Please let me know if you can help me for more information regarding the transfer. I hope you can work with me honestly?

Thanks.

Mustafa Sani,
